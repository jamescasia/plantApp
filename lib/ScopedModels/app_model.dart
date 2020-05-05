import 'dart:async';

import 'package:plantApp/DataModels/Listing.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:plantApp/UtilityModels/UserAdapter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plantApp/DataModels/AppAuth.dart';
import 'package:plantApp/DataModels/AppDatabase.dart';
import 'package:plantApp/DataModels/AppStorage.dart';
import 'dart:io';
import 'dart:convert';

class AppModel extends Model {
  UserAdapter userAdapter;
  AppAuth appAuth;
  AppDatabase appDatabase;
  AuthState authState = AuthState.LoggedOut;
  SignUpState signUpState = SignUpState.NotSignedUp;
  AppStorage appStorage;
  List<String> sellListingsIds = [];
  List<String> shareListingsIds = [];
  List<String> buyListingsIds = [];
  StreamSubscription listenForNewSellListings;
  StreamSubscription listenForNewShareListings;
  StreamSubscription listenForNewBuyListings;
  AppModel() {
    initialize();
  }
  initialize() {
    userAdapter = UserAdapter();
    appAuth = AppAuth();
    appDatabase = AppDatabase();
    appStorage = AppStorage();

    sellListingsIds = [];
    shareListingsIds = [];
    buyListingsIds = [];
  }

  cancelListeners() {
    try {
      listenForNewSellListings.cancel();
    } catch (e) {}
  }

  initializeListeners() {
    cancelListeners();
    listenForNewSellListings =
        appDatabase.sellListingsRef.onChildAdded.listen((event) {
      if (!sellListingsIds.contains(event.snapshot.key)) {
        ListingSelling ls = ListingSelling.fromJson(
            jsonDecode(event.snapshot.value.toString()));

        userAdapter.user.sellListings.add(ls);
        userAdapter.user.allListings.add(ls);
      }
      // Fluttertoast.showToast(
      //     msg: "${event.snapshot.value}",
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     fontSize: 16.0);
      notifyListeners();
    });
  }

  logInScreenLogIn(email, pass) async {}
  logInScreenLogOut() async {
    try {
      cancelListeners();
    } catch (e) {}

    try {
      authState = AuthState.LoggingOut;
      print(authState);

      notifyListeners();
      await appAuth.logOut();
      userAdapter.fUser = null;

      authState = AuthState.LoggedOut;
    } catch (E) {
      authState = AuthState.LoggedIn;
    }

    notifyListeners();

    initialize();
  }

  logInScreenGoogleLogIn() async {
    try {
      authState = AuthState.LoggingIn;
      print(authState);

      notifyListeners();

      userAdapter.gUser = await appAuth.signUpWithGoogle();
      authState = AuthState.LoggedIn;

      userAdapter.uid = userAdapter.gUser.id.toString();
      var exists = await appDatabase.userExists(userAdapter.uid);
      if (!exists) {
        authState = AuthState.InvalidLogIn;
        Future.delayed(const Duration(milliseconds: 2500), () {
          authState = AuthState.LoggedOut;

          print(authState);
          notifyListeners();
        });

        appAuth.logOut();

        Fluttertoast.showToast(
            msg: "User does not exist. Register first!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);
        return authState;
      }

      notifyListeners();

      await initializeHomePage();

      print(authState);
    } catch (E) {
      print("error");
      print(E.toString());
      authState = AuthState.InvalidLogIn;
      Future.delayed(const Duration(milliseconds: 2500), () {
        authState = AuthState.LoggedOut;

        print(authState);
        notifyListeners();
      });
    }

    return authState;
  }

  signUpPageSignUp(name, email, pass) async {}

  signUpPageGoogleSignUp(
      String address,
      String addressLatitude,
      String addressLongitude,
      String bio,
      String mainPhoneNumber,
      String altPhoneNumber) async {
    appAuth.logOut();

    try {
      signUpState = SignUpState.SigningUp;
      print(signUpState);

      notifyListeners();
      userAdapter.gUser = await appAuth.signUpWithGoogle();
      userAdapter.uid = userAdapter.gUser.id.toString();

      var exists = await appDatabase.userExists(userAdapter.uid);
      if (exists) {
        Fluttertoast.showToast(
            msg: "User already registered! Logging in.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0);

        signUpState = SignUpState.SignedUpWithGoogle;
        await appDatabase.initializeUserDatabase(userAdapter.uid);
        userAdapter.user.userInfo =
            await appDatabase.fetchUserInfo(userAdapter.uid);

        authState = AuthState.LoggedIn;
        initializeListeners();
        notifyListeners();
      } else {
        print(userAdapter.gUser);

        await appDatabase.addNewUser(
            userAdapter.gUser.displayName,
            userAdapter.gUser.email.toString(),
            userAdapter.uid,
            "https://66.media.tumblr.com/31a0dbc0f988a3b66bafcc84e9140283/tumblr_oouogcBENJ1w5mpldo7_250.png",
            bio,
            mainPhoneNumber,
            altPhoneNumber,
            address,
            addressLatitude,
            addressLongitude);
        await appDatabase.initializeUserDatabase(userAdapter.uid);

        userAdapter.user.userInfo =
            await appDatabase.fetchUserInfo(userAdapter.uid);

        authState = AuthState.LoggedIn;
        initializeListeners();

        signUpState = SignUpState.SignedUpWithGoogle;
        notifyListeners();
      }
    } catch (E) {
      signUpState = SignUpState.InvalidSignUp;
      authState = AuthState.LoggedOut;
      Fluttertoast.showToast(
          msg: "Unexpected Error. Please try again.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 16.0);
    }

    print(signUpState);
    return signUpState;
  }

// screen build function calls this one.
  initializeHomePage() async {
    await appDatabase.initializeUserDatabase(userAdapter.uid);
    userAdapter.user.userInfo =
        await appDatabase.fetchUserInfo(userAdapter.uid);

    await homePageFetchSellListings();
    initializeListeners();
  }

  addPostPageAddNewSellListing(
      ListingSelling listing, File image1, File image2, File image3) async {
    bool success = true;
    if (image1 != null) {
      try {
        listing.image1Path = await appStorage.uploadFileAndRetrieveLink(image1);
      } catch (e) {
        return false;
      }
    }
    if (image2 != null) {
      try {
        listing.image2Path = await appStorage.uploadFileAndRetrieveLink(image2);
      } catch (e) {
        return false;
      }
    }
    if (image3 != null) {
      try {
        listing.image3Path = await appStorage.uploadFileAndRetrieveLink(image3);
      } catch (e) {
        return false;
      }
    }
    try {
      await appDatabase.addNewSellListing(listing);
    } catch (e) {
      success = false;
    }
    return success;
  }

  homePageFetchSellListings() async {
    var sellListings = await appDatabase.fetchSellListings();
    sellListings.forEach((slt) {
      if (!sellListingsIds.contains(slt.id)) {
        sellListingsIds.add(slt.id);

        userAdapter.user.sellListings.add(slt);
        userAdapter.user.allListings.add(slt);
      }
    });

    print("all listings");
    print(userAdapter.user.allListings);
  }
}

enum SignUpState {
  SigningUp,
  NotSignedUp,
  InvalidSignUp,
  SignedUp,
  SignedUpWithGoogle
}
enum AuthState { LoggedIn, LoggingIn, LoggedOut, LoggingOut, InvalidLogIn }
