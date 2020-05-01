import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantApp/DataModels/Globals.dart';
import 'package:plantApp/ScopedModels/app_model.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'HomePage.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController phoneNumber2Controller = TextEditingController();

  String address = "";
  String addressLatitude = "";
  String addressLongitude = "";

  double safePadding = 0;

  ScrollController sc = ScrollController();

  afterBuild() {
    print("done");
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
    if (_keyboardIsVisible()) {
      Future.delayed(Duration(milliseconds: 40)).then((_) {
        sc.animateTo(sc.position.maxScrollExtent * 0.5,
            duration: Duration(milliseconds: 100), curve: Curves.easeOut);
      });
    } else {
      print("closedZ");
      Future.delayed(Duration(milliseconds: 40)).then((_) {
        sc.animateTo(safePadding,
            duration: Duration(milliseconds: 100), curve: Curves.easeOut);
      });
    }
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.grey[100],
      systemNavigationBarColor: const Color(0xFF1BA977),
      // #61C350
    ));
    return SafeArea(
      child: new LayoutBuilder(builder: (context, constraints) {
        // print("constraints");
        // print(constraints.maxHeight);
        safePadding = Globals.height - constraints.maxHeight;
        print("padding");
        print(safePadding);
        // print(sc.position.maxScrollExtent);

        return ScopedModelDescendant<AppModel>(
            builder: (context, snapshot, appModel) {
          return Material(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              controller: sc,
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
                            flex: 1,
                            child: Container(
                                width: Globals.width,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Column(
                                        children: <Widget>[
                                          Text(
                                            "Welcome",
                                            style: TextStyle(
                                              fontFamily: "Lato",
                                              color: Colors.grey[900],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 40,
                                            ),
                                          ),
                                          Text(
                                            "Sign-up",
                                            style: TextStyle(
                                              fontFamily: "Lato",
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
                            flex: 5,
                            child: Container(
                                // color: Colors.red,
                                width: Globals.width,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          // Container(
                                          //   margin: EdgeInsets.symmetric(
                                          //       vertical: Globals.dheight * 7),
                                          //   height: Globals.dheight * 50,
                                          //   decoration: BoxDecoration(
                                          //       color: Colors.grey[350],
                                          //       borderRadius: BorderRadius.all(
                                          //           Radius.circular(10)),
                                          //       border: Border.all(
                                          //           color: Colors.grey[400])),
                                          //   padding: EdgeInsets.only(
                                          //       left: 10,
                                          //       right: 10,
                                          //       bottom: 10),
                                          //   width: Globals.width * 0.8,
                                          //   child: Center(
                                          //     child: TextField(
                                          //       style: TextStyle(
                                          //           fontFamily: "Lato"),
                                          //       controller: nameController,
                                          //       decoration: new InputDecoration
                                          //               .collapsed(
                                          //           hintText: 'Name'),
                                          //     ),
                                          //   ),
                                          // ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: Globals.dheight * 7),
                                            height: Globals.dheight * 50,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[350],
                                                borderRadius: BorderRadius.all(
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
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                style: TextStyle(
                                                    fontFamily: "Lato"),
                                                controller: emailController,
                                                decoration: new InputDecoration
                                                        .collapsed(
                                                    hintText: 'Email address'),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: Globals.dheight * 7),
                                            height: Globals.dheight * 50,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[350],
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                    color: Colors.grey[400])),
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                            width: Globals.width * 0.8,
                                            child: InkWell(
                                              onTap: () async {
                                                print("choose from map");
                                              },
                                              child: Center(
                                                child: Stack(
                                                  children: <Widget>[
                                                    TextField(
                                                      enabled: false,
                                                      style: TextStyle(
                                                          fontFamily: "Lato"),
                                                      controller:
                                                          addressController,
                                                      decoration:
                                                          new InputDecoration
                                                                  .collapsed(
                                                              hintText:
                                                                  'Address'),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: FaIcon(
                                                          FontAwesomeIcons.mapMarked,
                                                          color:
                                                              Colors.grey[600]),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: Globals.dheight * 7),
                                            height: Globals.dheight * 50,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[350],
                                                borderRadius: BorderRadius.all(
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
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(
                                                    fontFamily: "Lato"),
                                                controller:
                                                    phoneNumberController,
                                                decoration: new InputDecoration
                                                        .collapsed(
                                                    hintText:
                                                        'Main Phone Number'),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: Globals.dheight * 7),
                                            height: Globals.dheight * 50,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[350],
                                                borderRadius: BorderRadius.all(
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
                                                keyboardType:
                                                    TextInputType.number,
                                                style: TextStyle(
                                                    fontFamily: "Lato"),
                                                controller:
                                                    phoneNumber2Controller,
                                                decoration: new InputDecoration
                                                        .collapsed(
                                                    hintText:
                                                        'Alt Phone Number (Optional)'),
                                              ),
                                            ),
                                          ),

                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: Globals.dheight * 7),
                                            height: Globals.dheight * 50 * 1.5,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[350],
                                                borderRadius: BorderRadius.all(
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
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontFamily: "Lato"),
                                                controller: bioController,
                                                decoration: new InputDecoration
                                                    .collapsed(hintText: 'Bio'),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: Globals.dheight * 7),
                                            height: Globals.dheight * 50,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[350],
                                                borderRadius: BorderRadius.all(
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
                                                    fontFamily: "Lato"),
                                                obscureText: true,
                                                controller: passwordController,
                                                decoration: new InputDecoration
                                                        .collapsed(
                                                    hintText: 'Password'),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: Globals.dheight * 7),
                                            height: Globals.dheight * 50,
                                            decoration: BoxDecoration(
                                                color: Colors.grey[350],
                                                borderRadius: BorderRadius.all(
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
                                                    fontFamily: "Lato"),
                                                obscureText: true,
                                                controller: password2Controller,
                                                decoration: new InputDecoration
                                                        .collapsed(
                                                    hintText:
                                                        'Re-enter password'),
                                              ),
                                            ),
                                          ),
                                        ]),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        // Center(
                                        //     child: Text(
                                        //   "or sign up with",
                                        //   style: TextStyle(
                                        //       fontFamily: "Lato",
                                        //       fontWeight: FontWeight.w600,
                                        //       color: Colors.grey[900],
                                        //       fontSize: 18),
                                        // )),
                                        // SizedBox(height: Globals.dheight * 9),
                                        Container(
                                          width: Globals.width * 0.8,
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                MaterialButton(
                                                  color: Colors.red,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  6))),
                                                  onPressed: () async {
                                                    FocusScope.of(context)
                                                        .requestFocus(
                                                            FocusNode());
                                                    print("sign up pressed");
                                                    if (appModel.signUpState ==
                                                        SignUpState
                                                            .InvalidSignUp)
                                                      return;
                                                    var success = await appModel
                                                        .signUpPageGoogleSignUp(
                                                            address,
                                                            addressLatitude,
                                                            addressLongitude,
                                                            bioController.text,
                                                            phoneNumberController
                                                                .text,
                                                            phoneNumber2Controller
                                                                .text);
                                                    if (success ==
                                                            SignUpState
                                                                .SignedUpWithGoogle ||
                                                        success ==
                                                            SignUpState
                                                                .SignedUp) {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          new MaterialPageRoute(
                                                              builder: (BuildContext
                                                                      context) =>
                                                                  HomePage()));
                                                    }
                                                  },
                                                  height: Globals.dheight * 60,
                                                  minWidth: Globals.width * 0.8,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      //insert google logo here
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                bottom: 7),
                                                        child: Image.asset(
                                                          "assets/app_icons/google.png",
                                                          height:
                                                              Globals.dheight *
                                                                  40,
                                                          scale: 2,
                                                        ),
                                                      ),
                                                      SizedBox(width: 1),
                                                      Text(
                                                        "GOOGLE",
                                                        style: TextStyle(
                                                            fontFamily: "Lato",
                                                            color: Colors.white,
                                                            fontSize: 17),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                    Center(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Already have an account? ",
                                          style: TextStyle(
                                              fontFamily: "Lato",
                                              color: Colors.grey[900],
                                              fontSize: 17),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            "Log-in",
                                            style: TextStyle(
                                                fontFamily: "Lato",
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
                  Container(height: Globals.height * 0.4)
                ],
              ),
            ),
          );
        });
      }),
    );
  }
}
