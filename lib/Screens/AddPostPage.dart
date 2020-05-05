import 'dart:async';
import 'dart:io';

import 'package:scoped_model/scoped_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plantApp/DataModels/Globals.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:plantApp/DataModels/Listing.dart';
import 'package:plantApp/ScopedModels/app_model.dart';
import 'package:plantApp/Screens/elements/SellingForm.dart';
import 'package:plantApp/Screens/elements/BuyingForm.dart';
import 'package:plantApp/Screens/elements/SharingForm.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddPostPage extends StatefulWidget {
  @override
  _AddPostPageState createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  ListingType selectedMode = ListingType.Sharing;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Globals.commonGreen,
        systemNavigationBarColor: Globals.commonGreen
        // #61C350
        ));
    return WillPopScope(
      onWillPop: () {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Globals.grayHomeBg,
          // #61C350
        ));

        return Future.value(true);
      },
      child: SafeArea(
        child: Container(
            width: Globals.width,
            height: Globals.height,
            child: Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(
                    color: Colors.white, //change your color here
                  ),
                  backgroundColor: Globals.commonGreen,
                  title: Text(
                    "Add Post",
                    // variable
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: Globals.dwidth * 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                body: Container(
                  width: Globals.width,
                  color: Colors.white,
                  height: Globals.height,
                  padding: EdgeInsets.only(
                      left: Globals.dwidth * 20,
                      right: Globals.dwidth * 10,
                      top: Globals.dwidth * 0),
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: Globals.dheight * 25,
                          ),
                          Text(
                            "What are you posting?",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: Globals.dwidth * 22,
                                fontWeight: FontWeight.w600,
                                color: Globals.mildBlack),
                          ),
                          SizedBox(
                            height: Globals.dheight * 8,
                          ),
                          CustomRadioButton(
                            enableShape: true,
                            horizontal: false,
                            elevation: 0,
                            width: Globals.dwidth * 100,
                            buttonColor: Colors.grey[100],
                            customShape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(300))),
                            buttonLables: [
                              'Sharing',
                              'Buying',
                              'Selling',
                            ],
                            buttonValues: [
                              ListingType.Sharing,
                              ListingType.Buying,
                              ListingType.Selling,
                            ],
                            radioButtonValue: (value) {
                              setState(() {
                                selectedMode = value;
                              });
                            },
                            selectedColor: Globals.profileYellow,
                          ),
                          SizedBox(
                            height: Globals.dheight * 8,
                          ),
                          (selectedMode == ListingType.Sharing)
                              ? SharingForm()
                              : (selectedMode == ListingType.Buying)
                                  ? BuyingForm()
                                  : SellingForm()
                        ]),
                  ),
                ))),
      ),
    );
  }
}

enum ListingType { Sharing, Buying, Selling }
enum PostState { Idle, Uploading }
