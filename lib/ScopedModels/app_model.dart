import 'package:scoped_model/scoped_model.dart';
import 'package:plantApp/UtilityModels/UserAdapter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:plantApp/DataModels/AppAuth.dart';
import 'package:plantApp/DataModels/AppDatabase.dart';

class AppModel extends Model {
  UserAdapter userAdapter;
  AppAuth appAuth;
  AppDatabase appDatabase;
  AuthState authState = AuthState.LoggedOut;
  SignUpState signUpState = SignUpState.NotSignedUp;

  initialize() {
    userAdapter = UserAdapter();
    appAuth = AppAuth();
    appDatabase = AppDatabase();
  }

  cancelListeners() {}

  initializeListeners() {}

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

  logInScreenGoogleLogIn() async {}
  

  signUpPageSignUp(name, email, pass) async {}

  signUpPageGoogleSignUp() async {
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

        authState = AuthState.LoggedIn;
        initializeListeners();
        notifyListeners();
      } else {
        print(userAdapter.gUser);
 

        await appDatabase.addNewUser(
            userAdapter.gUser.displayName,
            userAdapter.gUser.email.toString(),
            userAdapter.uid,
            "https://66.media.tumblr.com/31a0dbc0f988a3b66bafcc84e9140283/tumblr_oouogcBENJ1w5mpldo7_250.png");
        await appDatabase.initializeUserDatabase(userAdapter.uid);

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
}

enum SignUpState {
  SigningUp,
  NotSignedUp,
  InvalidSignUp,
  SignedUp,
  SignedUpWithGoogle
}
enum AuthState { LoggedIn, LoggingIn, LoggedOut, LoggingOut, InvalidLogIn }
