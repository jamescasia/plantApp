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
import '../AddPostPage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class BuyingForm extends StatefulWidget {
  @override
  _BuyingFormState createState() => _BuyingFormState();
}

class _BuyingFormState extends State<BuyingForm> {
  File image1;
  File image2;
  File image3;
  PriceLabel selectedPriceLabel = PriceLabel.PerKilo;

  bool isNegotiable = true;
  bool isDelivery = true;
  bool isPickup = true;
  bool isCOD = true;
  bool agreed = false;
  PostState postingState = PostState.Idle;

  bool isFormValid() {
    bool validPrice = true;
    try {
      double.parse(priceController.text);
    } catch (e) {
      validPrice = false;
    }
    return (image1 != null || image2 != null || image3 != null) &&
        validPrice &&
        titleController.text.isNotEmpty &&
        descController.text.isNotEmpty &&
        agreed;
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return Container(
        width: Globals.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: Globals.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Add Photos",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: Globals.dwidth * 16,
                        fontWeight: FontWeight.w600,
                        color: Globals.mildBlack),
                  ),
                  SizedBox(
                    height: Globals.dheight * 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      DottedBorder(
                        gap: 6,
                        color: (image1 == null)
                            ? Colors.grey[400]
                            : Colors.red.withAlpha(0),
                        strokeWidth: 2,
                        child: InkWell(
                          onTap: () async {
                            image1 = await ImagePicker.pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 80,
                                maxWidth: 600,
                                maxHeight: 800);
                            setState(() {});
                          },
                          child: Container(
                              width: Globals.width * 0.22,
                              height: Globals.width * 0.27,
                              child: (image1 == null)
                                  ? Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                          FaIcon(FontAwesomeIcons.photoVideo,
                                              color: Colors.grey[500],
                                              size: Globals.dwidth * 18),
                                          Text(
                                            "Select Photo",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: "Lato",
                                                fontSize: Globals.dwidth * 10,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey[500]),
                                          ),
                                        ]))
                                  : ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            width: Globals.width * 0.22,
                                            height: Globals.width * 0.27,
                                            child: Image.file(image1,
                                                fit: BoxFit.cover),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            color: Colors.grey.withAlpha(120),
                                          ),
                                          Center(
                                            child: FaIcon(Icons.edit,
                                                color: Colors.white,
                                                size: Globals.dwidth * 18),
                                          ),
                                        ],
                                      ),
                                    )),
                        ),
                      ),
                      SizedBox(width: Globals.dwidth * 7),
                      DottedBorder(
                        gap: 6,
                        color: (image2 == null)
                            ? Colors.grey[400]
                            : Colors.red.withAlpha(0),
                        strokeWidth: 2,
                        child: InkWell(
                          onTap: () async {
                            image2 = await ImagePicker.pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 80,
                                maxWidth: 600,
                                maxHeight: 800);
                            setState(() {});
                          },
                          child: Container(
                              width: Globals.width * 0.22,
                              height: Globals.width * 0.27,
                              child: (image2 == null)
                                  ? Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                          FaIcon(FontAwesomeIcons.photoVideo,
                                              color: Colors.grey[500],
                                              size: Globals.dwidth * 18),
                                          Text(
                                            "Select Photo",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: "Lato",
                                                fontSize: Globals.dwidth * 10,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey[500]),
                                          ),
                                        ]))
                                  : ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            width: Globals.width * 0.29,
                                            height: Globals.width * 0.34,
                                            child: Image.file(image2,
                                                fit: BoxFit.cover),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            color: Colors.grey.withAlpha(120),
                                          ),
                                          Center(
                                            child: FaIcon(Icons.edit,
                                                color: Colors.white,
                                                size: Globals.dwidth * 18),
                                          ),
                                        ],
                                      ),
                                    )),
                        ),
                      ),
                      SizedBox(width: Globals.dwidth * 7),
                      DottedBorder(
                        gap: 6,
                        color: (image3 == null)
                            ? Colors.grey[400]
                            : Colors.red.withAlpha(0),
                        strokeWidth: 2,
                        child: InkWell(
                          onTap: () async {
                            image3 = await ImagePicker.pickImage(
                                source: ImageSource.gallery,
                                imageQuality: 80,
                                maxWidth: 600,
                                maxHeight: 800);
                            setState(() {});
                          },
                          child: Container(
                              width: Globals.width * 0.22,
                              height: Globals.width * 0.27,
                              child: (image3 == null)
                                  ? Center(
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                          FaIcon(FontAwesomeIcons.photoVideo,
                                              color: Colors.grey[500],
                                              size: Globals.dwidth * 18),
                                          Text(
                                            "Select Photo",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: "Lato",
                                                fontSize: Globals.dwidth * 10,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey[500]),
                                          ),
                                        ]))
                                  : ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      child: Stack(
                                        children: <Widget>[
                                          Container(
                                            width: Globals.width * 0.22,
                                            height: Globals.width * 0.27,
                                            child: Image.file(image3,
                                                fit: BoxFit.cover),
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            color: Colors.grey.withAlpha(120),
                                          ),
                                          Center(
                                            child: FaIcon(Icons.edit,
                                                color: Colors.white,
                                                size: Globals.dwidth * 18),
                                          ),
                                        ],
                                      ),
                                    )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: Globals.dheight * 10),
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: Globals.dwidth * 16,
                          fontWeight: FontWeight.w600,
                          color: Globals.mildBlack),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: Globals.dheight * 7),
                      height: Globals.dheight * 50,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.grey[300])),
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      width: Globals.width * 0.84,
                      child: Center(
                        child: TextField(
                          style: TextStyle(fontFamily: "Lato"),
                          controller: titleController,
                          maxLength: 64,
                          decoration: new InputDecoration.collapsed(
                              hintText: 'Type title here',
                              hintStyle: TextStyle(
                                  fontFamily: "Lato", color: Colors.grey[400])),
                        ),
                      ),
                    ),
                  ]),
            ),
            SizedBox(height: Globals.dheight * 10),
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Price",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: Globals.dwidth * 16,
                          fontWeight: FontWeight.w600,
                          color: Globals.mildBlack),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: Globals.dheight * 7),
                          height: Globals.dheight * 50,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: Colors.grey[300])),
                          padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          width: Globals.width * 0.4,
                          child: Center(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              style: TextStyle(fontFamily: "Lato"),
                              controller: priceController,
                              decoration: new InputDecoration.collapsed(
                                  hintText: '1000',
                                  hintStyle: TextStyle(
                                      fontFamily: "Lato",
                                      color: Colors.grey[400])),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Globals.dwidth * 20,
                        ),
                        Text(
                          selectedPriceLabel == PriceLabel.PerKilo
                              ? "Per Kilo"
                              : selectedPriceLabel == PriceLabel.PerPiece
                                  ? "Per Piece"
                                  : "Per Bundle",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: Globals.dwidth * 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[400]),
                        ),
                      ],
                    ),
                  ]),
            ),
            SizedBox(height: Globals.dheight * 10),
            CustomRadioButton(
              enableShape: true,
              horizontal: false,
              elevation: 0,
              width: Globals.dwidth * 80,
              buttonColor: Colors.grey[100],
              customShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(300))),
              buttonLables: [
                'Per Kilo',
                'Per Piece',
                'Per Bundle',
              ],
              buttonValues: [
                PriceLabel.PerKilo,
                PriceLabel.PerPiece,
                PriceLabel.PerBundle
              ],
              radioButtonValue: (value) {
                setState(() {
                  selectedPriceLabel = value;
                });
              },
              selectedColor: Globals.commonGreen,
            ),
            SizedBox(height: Globals.dheight * 10),
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: Globals.dwidth * 16,
                          fontWeight: FontWeight.w600,
                          color: Globals.mildBlack),
                    ),
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: Globals.dheight * 7),
                      height: Globals.dheight * 50 * 2.3,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.grey[300])),
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      width: Globals.width * 0.84,
                      child: Center(
                        child: TextField(
                          maxLines: 4,
                          maxLength: 160,
                          style: TextStyle(fontFamily: "Lato"),
                          controller: descController,
                          decoration: new InputDecoration.collapsed(
                              hintText: 'Type description here',
                              hintStyle: TextStyle(
                                  fontFamily: "Lato", color: Colors.grey[400])),
                        ),
                      ),
                    ),
                  ]),
            ),
            SizedBox(height: Globals.dheight * 10),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Are you looking for pickup?",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: Globals.dwidth * 16,
                        fontWeight: FontWeight.w600,
                        color: Globals.mildBlack),
                  ),
                  SizedBox(height: Globals.dheight * 10),
                  Container(
                    width: Globals.width * 0.7,
                    child: CustomRadioButton(
                      enableShape: true,
                      horizontal: false,
                      elevation: 0,
                      width: Globals.dwidth * 80,
                      buttonColor: Colors.grey[100],
                      customShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(300))),
                      buttonLables: ['Yes', 'No'],
                      buttonValues: [true, false],
                      radioButtonValue: (value) {
                        setState(() {
                          isPickup = value;
                        });
                      },
                      selectedColor:
                          (isPickup) ? Globals.commonGreen : Colors.red,
                    ),
                  ),
                  SizedBox(height: Globals.dheight * 10),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Are you looking for delivery?",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: Globals.dwidth * 16,
                              fontWeight: FontWeight.w600,
                              color: Globals.mildBlack),
                        ),
                        SizedBox(height: Globals.dheight * 10),
                        Container(
                          width: Globals.width * 0.7,
                          child: CustomRadioButton(
                            enableShape: true,
                            horizontal: false,
                            elevation: 0,
                            width: Globals.dwidth * 80,
                            buttonColor: Colors.grey[100],
                            customShape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(300))),
                            buttonLables: ['Yes', 'No'],
                            buttonValues: [true, false],
                            radioButtonValue: (value) {
                              setState(() {
                                isDelivery = value;
                              });
                            },
                            selectedColor:
                                (isDelivery) ? Globals.commonGreen : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Globals.dheight * 10),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Are you looking for COD (Cash on Delivery)?",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: Globals.dwidth * 16,
                                fontWeight: FontWeight.w600,
                                color: Globals.mildBlack)),
                        SizedBox(height: Globals.dheight * 10),
                        Container(
                          width: Globals.width * 0.7,
                          child: CustomRadioButton(
                            enableShape: true,
                            horizontal: false,
                            elevation: 0,
                            width: Globals.dwidth * 80,
                            buttonColor: Colors.grey[100],
                            customShape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(300))),
                            buttonLables: ['Yes', 'No'],
                            buttonValues: [true, false],
                            radioButtonValue: (value) {
                              setState(() {
                                isCOD = value;
                              });
                            },
                            selectedColor:
                                (isCOD) ? Globals.commonGreen : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Globals.dheight * 10),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Will this be negotiable?",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: Globals.dwidth * 16,
                                fontWeight: FontWeight.w600,
                                color: Globals.mildBlack)),
                        SizedBox(height: Globals.dheight * 10),
                        Container(
                          width: Globals.width * 0.7,
                          child: CustomRadioButton(
                            enableShape: true,
                            horizontal: false,
                            elevation: 0,
                            width: Globals.dwidth * 80,
                            buttonColor: Colors.grey[100],
                            customShape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(300))),
                            buttonLables: ['Yes', 'No'],
                            buttonValues: [true, false],
                            radioButtonValue: (value) {
                              setState(() {
                                isNegotiable = value;
                              });
                            },
                            selectedColor: (isNegotiable)
                                ? Globals.commonGreen
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Globals.dheight * 20),
            Row(
              children: <Widget>[
                Checkbox(
                    value: agreed,
                    onChanged: (value) {
                      setState(() {
                        agreed = value;
                      });
                    }),
                SizedBox(
                  width: Globals.dwidth * 4,
                ),
                Text(
                  "By posting you agree to the ",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: Globals.dwidth * 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[500]),
                ),
                Text(
                  "Terms and Conditions.",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontFamily: "Lato",
                      fontSize: Globals.dwidth * 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey[500]),
                ),
              ],
            ),
            SizedBox(height: Globals.dheight * 15),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  onPressed: () async {
                    if (isFormValid()) {
                      bool success = false;
                      // image
                      ListingBuying listing = ListingBuying(
                        title: titleController.text,
                        datePosted: DateTime.now().toIso8601String(),
                        desc: descController.text,
                        isCOD: isCOD,
                        isDelivery: isDelivery,
                        isPickup: isPickup,
                        isNegotiable: isNegotiable,
                        price: double.parse(priceController.text),
                        priceLabel: selectedPriceLabel,
                        poster: appModel.userAdapter.user.userInfo,
                      );
                      setState(() {
                        postingState = PostState.Uploading;
                      });

                      success = await appModel.addPostPageAddNewBuyListing(
                          listing, image1, image2, image3);

                      setState(() {
                        postingState = PostState.Idle;
                      });

                      if (!success) {
                        Fluttertoast.showToast(
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            msg:
                                "Upload failed. Check internet connection and try again.",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            fontSize: 16.0);
                      } else {
                        Fluttertoast.showToast(
                            backgroundColor: Colors.green,
                            textColor: Colors.white,
                            msg: "Listing posted!",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            fontSize: 16.0);
                        Navigator.of(context).pop();
                      }
                    } else {
                      Fluttertoast.showToast(
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          msg: "Some fields are invalid. Please try again",
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 1,
                          fontSize: 16.0);
                    }
                    ;
                  },
                  minWidth: Globals.width * 0.9,
                  height: Globals.dheight * 50,
                  color: Globals.commonGreen,
                  child: postingState == PostState.Idle
                      ? Text(
                          "POST",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: Globals.dwidth * 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        )
                      : CircularProgressIndicator(),
                ),
              ],
            ),
            SizedBox(height: Globals.dheight * 15)
          ],
        ),
      );
    });
  }
}
