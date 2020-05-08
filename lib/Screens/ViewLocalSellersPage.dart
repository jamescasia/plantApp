import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plantApp/DataModels/Globals.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'dart:ui' as ui;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plantApp/DataModels/UserInfo.dart';
import 'package:plantApp/Screens/OtherProfilePage.dart';
import 'package:plantApp/Screens/ProfilePage.dart';

import 'package:scoped_model/scoped_model.dart';
import 'package:plantApp/ScopedModels/app_model.dart';

class ViewLocalSellersPage extends StatefulWidget {
  @override
  _ViewLocalSellersPageState createState() => _ViewLocalSellersPageState();
}

class _ViewLocalSellersPageState extends State<ViewLocalSellersPage>
    with SingleTickerProviderStateMixin {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition initialPosition;
  bool isExpanded = false;
  var month = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];
  TabController tC;
  List<String> photoList = [];
  BitmapDescriptor markerIcon;
  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration(size: Size(48, 48)), 'assets/images/marker.png')
        .then((onValue) {
      markerIcon = onValue;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        return ScopedModelDescendant<AppModel>(
            builder: (context, child, appModel) {
          appModel.getLocalSellers();
          initialPosition = CameraPosition(
            target: LatLng(
                double.parse(
                    appModel.userAdapter.user.userInfo.addressLatitude),
                double.parse(
                    appModel.userAdapter.user.userInfo.addressLongitude)),
            zoom: 16,
          );
          return Container(
            width: Globals.width,
            height: Globals.height,
            color: Globals.grayHomeBg,
            child: Stack(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      topRight: Radius.circular(0)),
                  child: Container(
                      height: Globals.height * 0.70,
                      width: Globals.width,
                      child: Container(
                          width: Globals.width,
                          height: Globals.height * 0.7,
                          child: Stack(
                            children: <Widget>[
                              GoogleMap(
                                markers: Set<Marker>.of(
                                    appModel.getLocalSellers().map((e) {
                                  return Marker(
                                      icon: markerIcon,
                                      markerId: MarkerId(e.address),
                                      position: LatLng(
                                          double.parse(e.addressLatitude),
                                          double.parse(e.addressLongitude)));
                                }).toList()),
                                mapType: MapType.normal,
                                zoomControlsEnabled: false,
                                initialCameraPosition: initialPosition,
                                onMapCreated: (GoogleMapController controller) {
                                  _controller.complete(controller);
                                  BitmapDescriptor.fromAssetImage(
                                          ImageConfiguration(
                                              size: Size(48, 48)),
                                          'assets/images/marker.png')
                                      .then((onValue) {
                                    markerIcon = onValue;
                                    setState(() {
                                      
                                    });
                                  });
                                },
                              ),
                              Positioned(
                                  bottom:
                                      (isExpanded ? 230 : 70) * Globals.dheight,
                                  left: 0,
                                  right: 0,
                                  child: photoList.length == 3
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Opacity(
                                                opacity:
                                                    tC.index == 0 ? 1 : 0.5,
                                                child: Container(
                                                  width: tC.index == 0 ? 10 : 6,
                                                  height:
                                                      tC.index == 0 ? 10 : 6,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30))),
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Opacity(
                                                opacity:
                                                    tC.index == 1 ? 1 : 0.5,
                                                child: Container(
                                                  width: tC.index == 1 ? 10 : 6,
                                                  height:
                                                      tC.index == 1 ? 10 : 6,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30))),
                                                )),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Opacity(
                                                opacity:
                                                    tC.index == 2 ? 1 : 0.5,
                                                child: Container(
                                                  width: tC.index == 2 ? 10 : 6,
                                                  height:
                                                      tC.index == 2 ? 10 : 6,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  30))),
                                                )),
                                          ],
                                        )
                                      : photoList.length == 2
                                          ? Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Opacity(
                                                    opacity:
                                                        tC.index == 0 ? 1 : 0.5,
                                                    child: Container(
                                                      width: tC.index == 0
                                                          ? 10
                                                          : 6,
                                                      height: tC.index == 0
                                                          ? 10
                                                          : 6,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          30))),
                                                    )),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Opacity(
                                                    opacity:
                                                        tC.index == 1 ? 1 : 0.5,
                                                    child: Container(
                                                      width: tC.index == 1
                                                          ? 10
                                                          : 6,
                                                      height: tC.index == 1
                                                          ? 10
                                                          : 6,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          30))),
                                                    )),
                                              ],
                                            )
                                          : SizedBox())
                            ],
                          ))),
                ),
                Positioned(
                    bottom: 0,
                    left: 0,
                    child: GestureDetector(
                      onPanUpdate: (a) {
                        if (a.delta.dy > 0) {
                          isExpanded = false;
                        } else if (a.delta.dy < 0) {
                          isExpanded = true;
                        }
                        setState(() {});
                        print(a.delta);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey[800],
                                blurRadius: 4.0,
                                offset: Offset(0, 6),
                              ),
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                            child: AnimatedContainer(
                              curve: Curves.fastLinearToSlowEaseIn,
                              duration: Duration(milliseconds: 300),
                              width: Globals.width,
                              height: (isExpanded)
                                  ? Globals.height * 0.59
                                  : Globals.height * 0.38,
                              color: Globals.commonGreen,
                              child: Stack(children: [
                                Positioned(
                                  bottom: 0,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        width: Globals.width,
                                        height: Globals.height * 0.12,
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(
                                            left: Globals.dwidth * 24,
                                            bottom: Globals.dwidth * 8),
                                        child: Flex(
                                          direction: Axis.horizontal,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                "Nearby sellers",
                                                // variable
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                    fontFamily: "Lato",
                                                    fontSize:
                                                        Globals.dwidth * 28,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      ClipRRect(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(40),
                                              bottomLeft: Radius.circular(40),
                                              topRight: Radius.circular(0),
                                              bottomRight: Radius.circular(40)),
                                          child: AnimatedContainer(
                                            curve:
                                                Curves.fastLinearToSlowEaseIn,
                                            duration:
                                                Duration(milliseconds: 300),
                                            color: Colors.white,
                                            width: Globals.width,
                                            padding: EdgeInsets.all(
                                                Globals.dwidth * 2),
                                            height: (isExpanded)
                                                ? Globals.height * 0.445
                                                : 0.24 * Globals.height,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
                                              child: SingleChildScrollView(
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      top: Globals.dwidth * 10),
                                                  height:
                                                      Globals.height * 0.445,
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: appModel
                                                          .getLocalSellers()
                                                          .map((e) =>
                                                              SellerCard(e))
                                                          .toList(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          );
        });
      }),
    ));
  }
}

class FlairChip extends StatelessWidget {
  String text;
  FlairChip(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(300)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400],
            blurRadius: 1.0,
            offset: Offset(0, 1),
          ),
        ],
        color: text == 'COD'
            ? Colors.blue[900]
            : text == "Pickup" ? Colors.lightBlue : Colors.lightBlueAccent,
      ),
      child: Text(
        "$text",
        textAlign: TextAlign.start,
        style: TextStyle(
            fontFamily: "Lato",
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white),
      ),
    );
  }
}

class SellerCard extends StatelessWidget {
  UserInfo seller;
  SellerCard(this.seller);
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(builder: (context, child, appModel) {
      return InkWell(
        child: Container(
          // width: Globals.width * 0.8,
          height: Globals.dheight * 70,
          margin: EdgeInsets.symmetric(vertical: 3),
          child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(300)),
                    child: Container(
                      width: Globals.dwidth * 50,
                      height: Globals.dwidth * 50,
                      child: CachedNetworkImage(
                        imageUrl: seller.ppLink,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                Center(
                                  child: CircularProgressIndicator(
                                      value: downloadProgress.progress),
                                ),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error),
                      ),
                    )),
                SizedBox(
                  width: Globals.dwidth * 12,
                ),
                Expanded(
                  flex: 6,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${seller.name}",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: Globals.dwidth * 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700]),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "${seller.address}",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: Globals.dwidth * 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey[700]),
                        ),
                      ]),
                ),
                SizedBox(
                  width: Globals.dwidth * 15,
                ),
                Expanded(
                  flex: 1,
                  child: InkWell(
                      onTap: () {
                        if (seller.email ==
                            appModel.userAdapter.user.userInfo.email) {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ProfilePage()));
                        } else
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      OtherProfilePage(seller,
                                          appModel.getUserListings(seller))));
                      },
                      child: FaIcon(FontAwesomeIcons.user,
                          color: Colors.grey[600])),
                )
              ]),
        ),
      );
    });
  }
}

class ContactDetailsPopup extends StatelessWidget {
  String phone;
  String phone2;
  ContactDetailsPopup(this.phone, this.phone2);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white.withAlpha(0),
      elevation: 0,
      child: InkWell(
        focusColor: Colors.white.withAlpha(0),
        highlightColor: Colors.white.withAlpha(0),
        hoverColor: Colors.white.withAlpha(0),
        splashColor: Colors.white.withAlpha(0),
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: Globals.width,
          height: Globals.height,
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Expanded(child: SizedBox()),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(300))),
                color: Globals.contactSellerPurple,
                onPressed: () {},
                child: Container(
                  width: Globals.width * 0.36,
                  height: Globals.dheight * 36,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "$phone",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Lato",
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      SizedBox(width: Globals.dwidth * 5),
                      Align(
                          alignment: Alignment.centerRight,
                          child: FaIcon(FontAwesomeIcons.phone,
                              color: Colors.white, size: Globals.dwidth * 14))
                    ],
                  ),
                )),
            SizedBox(height: Globals.dheight * 1),
            phone2 != null
                ? MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(300))),
                    color: Globals.contactSellerPurple,
                    onPressed: () {},
                    child: Container(
                      width: Globals.width * 0.36,
                      height: Globals.dheight * 36,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "$phone2",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white),
                          ),
                          SizedBox(width: Globals.dwidth * 5),
                          Align(
                              alignment: Alignment.centerRight,
                              child: FaIcon(FontAwesomeIcons.phone,
                                  color: Colors.white,
                                  size: Globals.dwidth * 14))
                        ],
                      ),
                    ))
                : SizedBox(),
            SizedBox(height: Globals.dheight * 35),
          ]),
        ),
      ),
    );
  }
}
