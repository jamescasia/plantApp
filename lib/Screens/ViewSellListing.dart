import 'package:flutter/material.dart';
import 'package:plantApp/DataModels/Globals.dart';
import 'package:plantApp/DataModels/Listing.dart';
import 'package:plantApp/Screens/elements/ExpandingBottomPanelSelling.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ViewSellListing extends StatefulWidget {
  ListingSelling listing;
  ViewSellListing(this.listing);
  @override
  _ViewSellListingState createState() => _ViewSellListingState(this.listing);
}

class _ViewSellListingState extends State<ViewSellListing> {
  ListingSelling listing;
  _ViewSellListingState(this.listing);
  bool isExpanded = false;
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
                    child: PhotoArray(photoList, isExpanded, UniqueKey())),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
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
                                          "Hydroponic-grown tomatoes",
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
                                    padding: EdgeInsets.all(Globals.dwidth * 2),
                                    height: (isExpanded)
                                        ? Globals.height * 0.445
                                        : 0.24 * Globals.height,
                                    child: Column(children: [
                                      // variable
                                      SizedBox(
                                        height: 3 * Globals.dheight,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          SizedBox(width: Globals.dwidth * 30),
                                          Text(
                                            "April 28",
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                fontFamily: "Lato",
                                                fontSize: Globals.dwidth * 14,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.grey[500]),
                                          ),
                                        ],
                                      ),
                                    ]),
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
                                      "P 25",
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
                                        "/kg",
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
                  ))
            ],
          ),
        );
      }),
    ));
  }
}

class PhotoArray extends StatefulWidget {
  Key key;
  List<String> photos;
  bool isExpanded;
  PhotoArray(this.photos, this.isExpanded, this.key);
  @override
  _PhotoArrayState createState() =>
      _PhotoArrayState(this.photos, this.isExpanded, this.key);
}

class _PhotoArrayState extends State<PhotoArray>
    with SingleTickerProviderStateMixin {
  List<String> photos;
  TabController tC;
  bool isExpanded;
  Key key;

  _PhotoArrayState(this.photos, this.isExpanded, this.key);

  @override
  void initState() {
    super.initState();
    tC = TabController(length: photos.length, vsync: this);

    tC.animation.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Globals.width,
        height: Globals.height * 0.7,
        child: Stack(
          children: <Widget>[
            TabBarView(
              controller: tC,
              children: photos
                  .map(
                    (pLink) => CachedNetworkImage(
                      imageUrl: pLink,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  )
                  .toList(),
            ),
            Positioned(
                bottom: (isExpanded ? 230 : 70) * Globals.dheight,
                left: 0,
                right: 0,
                child: photos.length == 3
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Opacity(
                              opacity: tC.index == 0 ? 1 : 0.5,
                              child: Container(
                                width: tC.index == 0 ? 10 : 6,
                                height: tC.index == 0 ? 10 : 6,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30))),
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
                                        BorderRadius.all(Radius.circular(30))),
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
                                        BorderRadius.all(Radius.circular(30))),
                              )),
                        ],
                      )
                    : photos.length == 2
                        ? Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Opacity(
                                  opacity: tC.index == 0 ? 1 : 0.5,
                                  child: Container(
                                    width: tC.index == 0 ? 10 : 6,
                                    height: tC.index == 0 ? 10 : 6,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30))),
                                  )),
                            ],
                          )
                        : SizedBox())
          ],
        ));
  }
}
