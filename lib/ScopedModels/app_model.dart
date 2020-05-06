import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:plantApp/DataModels/AppAuth.dart';
import 'package:plantApp/DataModels/AppDatabase.dart';
import 'package:plantApp/DataModels/AppStorage.dart';
import 'package:plantApp/DataModels/Listing.dart';
import 'package:plantApp/DataModels/UserInfo.dart';
import 'package:plantApp/UtilityModels/UserAdapter.dart';
import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  UserAdapter userAdapter;
  AppAuth appAuth;
  AppDatabase appDatabase;
  AuthState authState = AuthState.LoggedOut;
  SignUpState signUpState = SignUpState.NotSignedUp;
  AppStorage appStorage;
  List<String> sellListingsIds = [];
  List<String> shareListingsIds = [];
  List<String> sellerIds = [];
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
    sellerIds = [];
  }

  cancelListeners() {
    try {
      listenForNewSellListings.cancel();
    } catch (e) {}

    try {
      listenForNewBuyListings.cancel();
    } catch (e) {}

    try {
      listenForNewShareListings.cancel();
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
      notifyListeners();
    });

    listenForNewBuyListings =
        appDatabase.buyListingsRef.onChildAdded.listen((event) {
      if (!buyListingsIds.contains(event.snapshot.key)) {
        ListingBuying ls =
            ListingBuying.fromJson(jsonDecode(event.snapshot.value.toString()));

        userAdapter.user.buyListings.add(ls);
        userAdapter.user.allListings.add(ls);
      }
      notifyListeners();
    });

    listenForNewShareListings =
        appDatabase.shareListingsRef.onChildAdded.listen((event) {
      if (!shareListingsIds.contains(event.snapshot.key)) {
        ListingSharing ls = ListingSharing.fromJson(
            jsonDecode(event.snapshot.value.toString()));

        userAdapter.user.shareListings.add(ls);
        userAdapter.user.allListings.add(ls);
      }
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
      String altPhoneNumber,
      File ppImage) async {
    appAuth.logOut();

    try {
      signUpState = SignUpState.SigningUp;
      print(signUpState);
      notifyListeners();

      var imgLink = await appStorage.uploadFileAndRetrieveLink(ppImage);
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
            imgLink,
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
    await homePageFetchBuyListings();
    await homePageFetchShareListings();
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

  addPostPageAddNewBuyListing(
      ListingBuying listing, File image1, File image2, File image3) async {
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
      await appDatabase.addNewBuyListing(listing);
    } catch (e) {
      success = false;
    }
    return success;
  }

  addPostPageAddNewShareListing(
      ListingSharing listing, File image1, File image2, File image3) async {
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
      await appDatabase.addNewShareListing(listing);
    } catch (e) {
      success = false;
    }
    return success;
  }

  homePageFetchSellListings() async {
    List<ListingSelling> sellListings = await appDatabase.fetchSellListings();
    sellListings.forEach((slt) {
      if (!sellListingsIds.contains(slt.id)) {
        sellListingsIds.add(slt.id);

        userAdapter.user.sellListings.add(slt);
        userAdapter.user.allListings.add(slt);
        if (slt.poster.email == userAdapter.user.userInfo.email) {
          userAdapter.user.ownListings.add(slt);
        }
      }
    });

    print("all listings");
    // print(userAdapter.user.allListings);
  }

  homePageFetchBuyListings() async {
    List<ListingBuying> buyListings = await appDatabase.fetchBuyListings();
    buyListings.forEach((slt) {
      if (!buyListingsIds.contains(slt.id)) {
        buyListingsIds.add(slt.id);

        userAdapter.user.buyListings.add(slt);
        userAdapter.user.allListings.add(slt);
        if (slt.poster.email == userAdapter.user.userInfo.email) {
          userAdapter.user.ownListings.add(slt);
        }
      }
    });
  }

  homePageFetchShareListings() async {
    List<ListingSharing> shareListings = await appDatabase.fetchShareListings();
    shareListings.forEach((slt) {
      if (!shareListingsIds.contains(slt.id)) {
        shareListingsIds.add(slt.id);

        userAdapter.user.shareListings.add(slt);
        userAdapter.user.allListings.add(slt);
        if (slt.poster.email == userAdapter.user.userInfo.email) {
          userAdapter.user.ownListings.add(slt);
        }
      }
    });

    userAdapter.user.allListings.shuffle();
  }

  getUserListings(UserInfo user) {
    var otherListings = [];
    userAdapter.user.allListings.forEach((slt) {
      if (slt.poster.email == user.email) {
        otherListings.add(slt);
      }
    });
    return otherListings;
  }

  Set<UserInfo> getLocalSellers() {
    userAdapter.user.allListings.forEach((slr) {
      if (!sellerIds.contains(slr.poster.email) && slr is ListingSelling) {
        userAdapter.user.localSellers.add(slr.poster);
        sellerIds.add(slr.poster.email);
      }
    });
    return userAdapter.user.localSellers;
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
