import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plantApp/DataModels/Globals.dart';
import 'package:plantApp/ScopedModels/app_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'HomePage.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';

import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:io';

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
  File image1;

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
                            flex: 8,
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
                                                controller: addressController,
                                                decoration: new InputDecoration
                                                        .collapsed(
                                                    hintText: 'Address'),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Text("Get exact\nlocation:",
                                                  style: TextStyle(
                                                      fontFamily: "Lato",
                                                      fontSize: 14)),
                                              MaterialButton(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                500))),
                                                minWidth: Globals.dwidth * 20,
                                                color: Colors.white,
                                                onPressed: () async {
                                                  print("choose from map");

                                                  try {
                                                    LocationResult result =
                                                        await showLocationPicker(
                                                            context,
                                                            'AIzaSyAZsetHVt2lU2W16MWL6hnU7pSf57fCBJE');

                                                    addressLongitude = result
                                                        .latLng.longitude
                                                        .toString();
                                                    addressLatitude = result
                                                        .latLng.latitude
                                                        .toString();

                                                    setState(() {});

                                                    print("done picking");
                                                    print(address);
                                                    print(addressLatitude);
                                                    print(addressLongitude);
                                                  } catch (e) {
                                                    Fluttertoast.showToast(
                                                        backgroundColor:
                                                            Colors.red,
                                                        textColor: Colors.white,
                                                        msg:
                                                            "Error getting location. Please try again",
                                                        toastLength:
                                                            Toast.LENGTH_LONG,
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        timeInSecForIosWeb: 1,
                                                        fontSize: 16.0);
                                                  }
                                                },
                                                child: FaIcon(
                                                    FontAwesomeIcons.mapMarker,
                                                    color: Colors.red),
                                              ),
                                              FaIcon(
                                                  (addressLatitude == "")
                                                      ? FontAwesomeIcons
                                                          .question
                                                      : FontAwesomeIcons.check,
                                                  color: (addressLatitude == "")
                                                      ? Colors.grey[600]
                                                      : Colors.green)
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              image1 =
                                                  await ImagePicker.pickImage(
                                                      source:
                                                          ImageSource.gallery,
                                                      imageQuality: 80,
                                                      maxWidth: 300,
                                                      maxHeight: 300);
                                              setState(() {});
                                            },
                                            child: Container(
                                                width: Globals.width * 0.22,
                                                height: Globals.width * 0.27,
                                                child: (image1 == null)
                                                    ? Center(
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                            FaIcon(
                                                                FontAwesomeIcons
                                                                    .photoVideo,
                                                                color: Colors
                                                                    .grey[500],
                                                                size: Globals
                                                                        .dwidth *
                                                                    18),
                                                            Text(
                                                              "Select Photo",
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "Lato",
                                                                  fontSize:
                                                                      Globals.dwidth *
                                                                          10,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                          .grey[
                                                                      500]),
                                                            ),
                                                          ]))
                                                    : ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    300)),
                                                        child: Stack(
                                                          children: <Widget>[
                                                            Container(
                                                              width: Globals
                                                                      .width *
                                                                  0.18,
                                                              height: Globals
                                                                      .width *
                                                                  0.18,
                                                              child: Image.file(
                                                                  image1,
                                                                  fit: BoxFit
                                                                      .cover),
                                                            ),
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              color: Colors.grey
                                                                  .withAlpha(
                                                                      120),
                                                            ),
                                                            Center(
                                                              child: FaIcon(
                                                                  Icons.edit,
                                                                  color: Colors
                                                                      .white,
                                                                  size: Globals
                                                                          .dwidth *
                                                                      18),
                                                            ),
                                                          ],
                                                        ),
                                                      )),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: Globals.dheight * 7),
                                            height: Globals.dheight * 50 * 1.6,
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
                                                maxLength: 80,
                                                style: TextStyle(
                                                    fontFamily: "Lato"),
                                                controller: bioController,
                                                decoration: new InputDecoration
                                                    .collapsed(hintText: 'Bio'),
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
                                                    if (phoneNumberController
                                                                .text ==
                                                            "" ||
                                                        phoneNumberController
                                                                .text.length !=
                                                            11 ||
                                                        bioController.text ==
                                                            "" ||
                                                        addressLatitude == "" ||
                                                        image1 == null) {
                                                      Fluttertoast.showToast(
                                                          backgroundColor:
                                                              Colors.red,
                                                          textColor:
                                                              Colors.white,
                                                          msg:
                                                              "ERROR: Some fields left empty. Please try again.",
                                                          toastLength:
                                                              Toast.LENGTH_LONG,
                                                          gravity: ToastGravity
                                                              .BOTTOM,
                                                          timeInSecForIosWeb: 1,
                                                          fontSize: 16.0);
                                                      return;
                                                    }
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
                                                            addressController
                                                                .text,
                                                            addressLatitude,
                                                            addressLongitude,
                                                            bioController.text,
                                                            phoneNumberController
                                                                .text,
                                                            phoneNumber2Controller
                                                                .text,
                                                            image1);
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
