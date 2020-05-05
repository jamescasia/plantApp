import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:plantApp/DataModels/Globals.dart';
import 'package:plantApp/DataModels/Listing.dart';
import 'package:plantApp/Screens/elements/MapFragment.dart';

class ViewBuyListing extends StatefulWidget {
  ListingBuying listing;
  ViewBuyListing(this.listing);
  @override
  _ViewBuyListingState createState() => _ViewBuyListingState(this.listing);
}

class _ViewBuyListingState extends State<ViewBuyListing>
    with SingleTickerProviderStateMixin {
  ListingBuying listing;
  _ViewBuyListingState(this.listing);
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
  @override
  void initState() {
    if (!listing.image1Path.contains("null")) {
      photoList.add(listing.image1Path);
    }

    if (!listing.image2Path.contains("null")) {
      photoList.add(listing.image2Path);
    }
    if (!listing.image3Path.contains("null")) {
      photoList.add(listing.image3Path);
    }
    tC = TabController(length: photoList.length, vsync: this);

    tC.animation.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(child: SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        return Container(
          width: Globals.width,
          height: Globals.height,
          color: Globals.grayHomeBg,
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0), topRight: Radius.circular(0)),
                child: Container(
                    height: Globals.height * 0.70,
                    width: Globals.width,
                    child: Container(
                        width: Globals.width,
                        height: Globals.height * 0.7,
                        child: Stack(
                          children: <Widget>[
                            TabBarView(
                              controller: tC,
                              children: photoList
                                  .map(
                                    (pLink) => CachedNetworkImage(
                                      imageUrl: pLink,
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
                                  )
                                  .toList(),
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
                                              opacity: tC.index == 0 ? 1 : 0.5,
                                              child: Container(
                                                width: tC.index == 0 ? 10 : 6,
                                                height: tC.index == 0 ? 10 : 6,
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
                                              opacity: tC.index == 1 ? 1 : 0.5,
                                              child: Container(
                                                width: tC.index == 1 ? 10 : 6,
                                                height: tC.index == 1 ? 10 : 6,
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
                                              opacity: tC.index == 2 ? 1 : 0.5,
                                              child: Container(
                                                width: tC.index == 2 ? 10 : 6,
                                                height: tC.index == 2 ? 10 : 6,
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
                                                    width:
                                                        tC.index == 0 ? 10 : 6,
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
                                                    width:
                                                        tC.index == 1 ? 10 : 6,
                                                    height:
                                                        tC.index == 1 ? 10 : 6,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
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
                                            "${listing.title}",
                                            // variable
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: "Lato",
                                                fontSize: Globals.dwidth * 28,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Expanded(flex: 1, child: SizedBox()),
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
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      duration: Duration(milliseconds: 300),
                                      color: Colors.white,
                                      width: Globals.width,
                                      padding:
                                          EdgeInsets.all(Globals.dwidth * 2),
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
                                            height: Globals.height * 0.445,
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // variable
                                                  SizedBox(
                                                    height: 3 * Globals.dheight,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      SizedBox(
                                                          width:
                                                              Globals.dwidth *
                                                                  12),
                                                      Text(
                                                        "${month[DateTime.parse(listing.datePosted).month - 1]} ${DateTime.parse(listing.datePosted).day}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontFamily: "Lato",
                                                            fontSize:
                                                                Globals.dwidth *
                                                                    14,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: Colors
                                                                .grey[500]),
                                                      ),
                                                    ],
                                                  ),

                                                  SizedBox(
                                                      height:
                                                          Globals.dheight * 6),

                                                  Container(
                                                    height:
                                                        Globals.dheight * 26,
                                                    child: Row(
                                                      children: <Widget>[
                                                        FlairChip("BUYING"),
                                                        SizedBox(
                                                          width:
                                                              Globals.dwidth *
                                                                  6,
                                                        ),
                                                        listing.isCOD
                                                            ? FlairChip("COD")
                                                            : SizedBox(),
                                                        SizedBox(
                                                          width:
                                                              Globals.dwidth *
                                                                  6,
                                                        ),
                                                        listing.isPickup
                                                            ? FlairChip(
                                                                "Pickup")
                                                            : SizedBox(),
                                                        SizedBox(
                                                          width:
                                                              Globals.dwidth *
                                                                  6,
                                                        ),
                                                        listing.isNegotiable
                                                            ? FlairChip(
                                                                "Negotiable")
                                                            : SizedBox(),
                                                      ],
                                                    ),
                                                  ),

                                                  SizedBox(
                                                      height:
                                                          Globals.dheight * 6),

                                                  Container(
                                                    height:
                                                        Globals.dheight * 74,
                                                    child: Text(
                                                      "${listing.desc}",
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 4,
                                                      style: TextStyle(
                                                          fontFamily: "Lato",
                                                          fontSize:
                                                              Globals.dwidth *
                                                                  16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color:
                                                              Colors.grey[600]),
                                                    ),
                                                  ),

                                                  SizedBox(
                                                      height:
                                                          Globals.dheight * 20),

                                                  Center(
                                                    child: Container(
                                                      child: Column(
                                                        children: <Widget>[
                                                          ClipRRect(
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          300)),
                                                              child: Container(
                                                                width: Globals
                                                                        .dheight *
                                                                    50,
                                                                height: Globals
                                                                        .dheight *
                                                                    50,
                                                                child: Center(
                                                                  child:
                                                                      CachedNetworkImage(
                                                                    imageUrl: listing
                                                                        .poster
                                                                        .ppLink,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    progressIndicatorBuilder: (context,
                                                                            url,
                                                                            downloadProgress) =>
                                                                        CircularProgressIndicator(
                                                                            value:
                                                                                downloadProgress.progress),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Icon(Icons
                                                                            .error),
                                                                  ),
                                                                ),
                                                              )),
                                                          SizedBox(
                                                              height: Globals
                                                                      .dheight *
                                                                  4),
                                                          Text(
                                                            "${listing.poster.name}",
                                                            textAlign:
                                                                TextAlign.start,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "Lato",
                                                                fontSize: Globals
                                                                        .dwidth *
                                                                    16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .grey[700]),
                                                          ),
                                                          SizedBox(
                                                            height: Globals
                                                                    .dheight *
                                                                12,
                                                          ),
                                                          Container(
                                                            width:
                                                                Globals.width *
                                                                    0.6,
                                                            child: InkWell(
                                                              onTap: () {
                                                                showGeneralDialog(
                                                                    barrierColor: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.5),
                                                                    transitionBuilder:
                                                                        (context,
                                                                            a1,
                                                                            a2,
                                                                            widget) {
                                                                      return Transform
                                                                          .scale(
                                                                        scale: a1
                                                                            .value,
                                                                        child: Opacity(
                                                                            opacity:
                                                                                a1.value,
                                                                            child: MapFragment(double.parse(listing.poster.addressLatitude), double.parse(listing.poster.addressLongitude))),
                                                                      );
                                                                    },
                                                                    transitionDuration:
                                                                        Duration(
                                                                            milliseconds:
                                                                                200),
                                                                    barrierDismissible:
                                                                        false,
                                                                    barrierLabel:
                                                                        '',
                                                                    context:
                                                                        context,
                                                                    pageBuilder:
                                                                        (context,
                                                                            animation1,
                                                                            animation2) {});
                                                              },
                                                              child: Text(
                                                                "${listing.poster.address}",
                                                                // variable
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    decoration:
                                                                        TextDecoration
                                                                            .underline,
                                                                    fontFamily:
                                                                        "Lato",
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    color: Colors
                                                                            .green[
                                                                        400]),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              height: Globals
                                                                      .dheight *
                                                                  14),
                                                          MaterialButton(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              300))),
                                                              color: Globals
                                                                  .contactSellerViolet,
                                                              onPressed: () {
                                                                showGeneralDialog(
                                                                    barrierColor:
                                                                        Colors.black
                                                                            .withAlpha(
                                                                                1),
                                                                    transitionBuilder:
                                                                        (context,
                                                                            a1,
                                                                            a2,
                                                                            widget) {
                                                                      return Transform
                                                                          .translate(
                                                                        offset: Offset(
                                                                            0,
                                                                            -a1.value),
                                                                        child: Opacity(
                                                                            opacity:
                                                                                a1.value,
                                                                            child: ContactDetailsPopup(listing.poster.mainPhoneNumber, listing.poster.altPhoneNumber)),
                                                                      );
                                                                    },
                                                                    transitionDuration:
                                                                        Duration(
                                                                            milliseconds:
                                                                                200),
                                                                    barrierDismissible:
                                                                        true,
                                                                    barrierLabel:
                                                                        '',
                                                                    context:
                                                                        context,
                                                                    pageBuilder:
                                                                        (context,
                                                                            animation1,
                                                                            animation2) {});
                                                              },
                                                              child: Container(
                                                                width: Globals
                                                                        .width *
                                                                    0.4,
                                                                height: Globals
                                                                        .dheight *
                                                                    46,
                                                                child: Stack(
                                                                  children: <
                                                                      Widget>[
                                                                    Center(
                                                                      child:
                                                                          Text(
                                                                        "Contact Buyer",
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "Lato",
                                                                            fontSize:
                                                                                18,
                                                                            fontWeight:
                                                                                FontWeight.w700,
                                                                            color: Colors.white),
                                                                      ),
                                                                    ),
                                                                    // Positioned(
                                                                    //     right:
                                                                    //         Globals.dwidth *
                                                                    //             4,
                                                                    //     top: 0,
                                                                    //     bottom: 0,
                                                                    //     child: Align(
                                                                    //         alignment: Alignment
                                                                    //             .centerRight,
                                                                    //         child: FaIcon(
                                                                    //             FontAwesomeIcons.times,
                                                                    //             color: Colors.white,
                                                                    //             size: Globals.dwidth * 30)))
                                                                  ],
                                                                ),
                                                              ))
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              right: Globals.dwidth * 14,
                              top: Globals.dheight * 90,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Globals.profileYellow,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[600],
                                        blurRadius: 1.0,
                                        offset: Offset(0, 0.5),
                                      ),
                                    ],
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                padding: EdgeInsets.symmetric(
                                    horizontal: Globals.dwidth * 10,
                                    vertical: Globals.dwidth * 3),
                                child: Wrap(
                                    alignment: WrapAlignment.center,
                                    crossAxisAlignment: WrapCrossAlignment.end,
                                    children: [
                                      // variable
                                      Text(
                                        "P ${listing.price.round()}",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontFamily: "Lato",
                                            fontSize: Globals.dwidth * 28,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: Globals.dwidth * 4),
                                        child: Text(
                                          priceLabelToString(
                                              listing.priceLabel),
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontFamily: "Lato",
                                              fontSize: Globals.dwidth * 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      )
                                    ]),
                              ),
                            )
                          ]),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        );
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
            : text == "Pickup"
                ? Colors.lightBlue
                : text == "BUYING"
                    ? Globals.contactSellerPurple
                    : Colors.lightBlueAccent,
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
