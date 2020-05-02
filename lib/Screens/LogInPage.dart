import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantApp/DataModels/Globals.dart';
import 'package:plantApp/Screens/HomePage.dart';
import 'package:plantApp/ScopedModels/app_model.dart';
import 'package:plantApp/Screens/SignUpPage.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:google_map_location_picker/generated/i18n.dart'
    as location_picker;
import 'package:progress_indicators/progress_indicators.dart';

class PlantApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
        model: AppModel(),
        child: MaterialApp(
          theme: ThemeData(fontFamily: 'Lato'),
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            location_picker.S.delegate,
          ],
          supportedLocales: const <Locale>[
            Locale('en', ''),
            Locale('ar', ''),
          ],
          home: LogInPage(),
        ));
  }
}

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}

class EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => Size(0.0, 0.0);
}

class _LogInPageState extends State<LogInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  double safePadding = 0;
  ScrollController sc = ScrollController();
  bool rebuildOnChange = false;
  bool runOnce = false;
  afterBuild() {
    sc.jumpTo(safePadding);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => afterBuild());

    super.initState();
  }

  bool _keyboardIsVisible() {
    return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
  }

  @override
  Widget build(BuildContext context) {
    Globals.dheight = MediaQuery.of(context).size.height / 793;
    Globals.dwidth = MediaQuery.of(context).size.width / 393;
    Globals.maxHeight = MediaQuery.of(context).size.height;
    Globals.maxWidth = MediaQuery.of(context).size.width;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Globals.grayHomeBg,
      systemNavigationBarColor: const Color(0xFF1BA977),
      // #61C350
    ));
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        safePadding = Globals.maxHeight - constraints.maxHeight;
        Globals.height = constraints.maxHeight;
        Globals.width = constraints.maxWidth;

        return Scaffold(
          appBar: EmptyAppBar(),
          body: ScopedModelDescendant<AppModel>(
              builder: (context, child, appModel) {
            return Material(
              child: SingleChildScrollView(
                controller: sc,
                physics: NeverScrollableScrollPhysics(),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: Globals.height,
                      width: Globals.width,
                      child: Flex(
                          direction: Axis.vertical,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                  width: Globals.width,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: Globals.dheight * 130,
                                          child: Image.asset(
                                            "assets/app_icons/google.png",
                                            height: Globals.dheight * 160,
                                            scale: 2,
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.greenAccent[400],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(1000))),
                                        ),
                                        SizedBox(height: Globals.dheight * 25),
                                        Column(
                                          children: <Widget>[
                                            Text(
                                              "Welcome",
                                              style: TextStyle(
                                                fontFamily: "QuickSand",
                                                color: Colors.grey[900],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 40,
                                              ),
                                            ),
                                            Text(
                                              "Log-in",
                                              style: TextStyle(
                                                fontFamily: "QuickSand",
                                                color: Colors.grey[900],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            )
                                          ],
                                        ),
                                      ])),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                  // color: Colors.red,
                                  width: Globals.width,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical:
                                                      Globals.dheight * 7),
                                              height: Globals.dheight * 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[350],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  border: Border.all(
                                                      color: Colors.grey[400])),
                                              padding: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 10),
                                              width: Globals.width * 0.8,
                                              child: Center(
                                                child: TextField(
                                                  style: TextStyle(
                                                      fontFamily: "QuickSand"),
                                                  controller: emailController,
                                                  decoration:
                                                      new InputDecoration
                                                              .collapsed(
                                                          hintText:
                                                              'Email address'),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical:
                                                      Globals.dheight * 7),
                                              height: Globals.dheight * 50,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[350],
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  border: Border.all(
                                                      color: Colors.grey[400])),
                                              padding: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 10),
                                              width: Globals.width * 0.8,
                                              child: Center(
                                                child: TextField(
                                                  style: TextStyle(
                                                      fontFamily: "QuickSand"),
                                                  controller:
                                                      passwordController,
                                                  obscureText: true,
                                                  decoration:
                                                      new InputDecoration
                                                              .collapsed(
                                                          hintText: 'Password'),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical:
                                                      Globals.dheight * 7),
                                              width: Globals.width * 0.8,
                                              child: MaterialButton(
                                                enableFeedback:
                                                    (appModel.authState ==
                                                        AuthState.LoggedOut),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10))),
                                                onPressed: (!(emailController
                                                                    .text
                                                                    .toString()
                                                                    .length ==
                                                                0 ||
                                                            passwordController
                                                                    .text
                                                                    .toString()
                                                                    .length ==
                                                                0) &&
                                                        appModel.authState !=
                                                            AuthState.LoggingIn)
                                                    ? () async {
                                                        FocusScope.of(context)
                                                            .requestFocus(
                                                                FocusNode());
                                                        if (appModel
                                                                .authState ==
                                                            AuthState
                                                                .InvalidLogIn)
                                                          return;
                                                        var success = await appModel
                                                            .logInScreenLogIn(
                                                                emailController
                                                                    .text,
                                                                passwordController
                                                                    .text);
                                                        if (success ==
                                                            AuthState
                                                                .LoggedIn) {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              new MaterialPageRoute(
                                                                  builder: (BuildContext
                                                                          context) =>
                                                                      HomePage()));
                                                        }
                                                      }
                                                    : null,
                                                disabledColor:
                                                    Colors.greenAccent[400],
                                                color: (appModel.authState ==
                                                        AuthState.InvalidLogIn)
                                                    ? Colors.red
                                                    : Colors.greenAccent[400],
                                                height: Globals.dheight * 50,
                                                minWidth: Globals.width * 0.8,
                                                child: Center(
                                                  child: (appModel.authState ==
                                                              AuthState
                                                                  .LoggedOut ||
                                                          appModel.authState ==
                                                              AuthState
                                                                  .LoggedIn)
                                                      ? Text(
                                                          "LOG IN",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "QuickSand",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18),
                                                        )
                                                      : (appModel.authState ==
                                                              AuthState
                                                                  .LoggingIn)
                                                          ? JumpingText("...",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "QuickSand",
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 35))
                                                          : Text(
                                                              "INVALID",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "QuickSand",
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 18),
                                                            ),
                                                ),
                                              ),
                                            )
                                          ]),
                                      SizedBox(height: Globals.dheight * 5),
                                      Container(
                                        width: Globals.width * 0.8,
                                        child: MaterialButton(
                                          color: Colors.red,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6))),
                                          onPressed: () async {
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            if (appModel.authState ==
                                                AuthState.InvalidLogIn) return;
                                            var success = await appModel
                                                .logInScreenGoogleLogIn();
                                            if (success == AuthState.LoggedIn) {
                                              Navigator.pushReplacement(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          HomePage()));
                                            }
                                          },
                                          height: Globals.dheight * 50,
                                          minWidth: Globals.width * 0.8,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              //insert google logo here
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 7),
                                                child: Image.asset(
                                                  "assets/app_icons/google.png",
                                                  height: Globals.dheight * 40,
                                                  scale: 2,
                                                ),
                                              ),
                                              SizedBox(width: 1),
                                              Text(
                                                "GOOGLE",
                                                style: TextStyle(
                                                    fontFamily: "QuickSand",
                                                    color: Colors.white,
                                                    fontSize: 17),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: Globals.dheight * 14),
                                      Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Don't have an account? ",
                                            style: TextStyle(
                                                fontFamily: "QuickSand",
                                                color: Colors.grey[900],
                                                fontSize: 17),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              appModel.logInScreenLogOut();
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          SignUpPage()));
                                            },
                                            child: Text(
                                              "Sign-up",
                                              style: TextStyle(
                                                  fontFamily: "QuickSand",
                                                  color: Colors.blue,
                                                  fontSize: 17),
                                            ),
                                          ),
                                        ],
                                      )),
                                    ],
                                  )),
                            )
                          ]),
                    ),
                    Container(height: Globals.height * 0.33)
                  ],
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}
