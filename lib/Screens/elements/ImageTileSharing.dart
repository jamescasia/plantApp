import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:plantApp/DataModels/Globals.dart';
import 'package:plantApp/DataModels/Listing.dart';
import 'package:plantApp/Screens/ViewImage.dart';
import 'package:plantApp/Screens/ViewShareListing.dart';

class ImageTileSharing extends StatefulWidget {
  ListingSharing listing;
  int index;
  double heightRatio;
  ImageTileSharing(this.listing, this.heightRatio, this.index);

  @override
  _ImageTileSharingState createState() =>
      _ImageTileSharingState(this.listing, this.heightRatio, this.index);
}

class _ImageTileSharingState extends State<ImageTileSharing> {
  ListingSharing listing;
  int index;
  double heightRatio;
  _ImageTileSharingState(this.listing, this.heightRatio, this.index);

  displayImage() {
    return !listing.image1Path.contains("null")
        ? listing.image1Path
        : !listing.image2Path.contains("null")
            ? listing.image2Path
            : listing.image3Path;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: (index == 0 || index == 1) ? 20 : 0),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.all(Radius.circular(24)),
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
          child: InkWell(
              borderRadius: BorderRadius.all(Radius.circular(24)),
              highlightColor: Colors.red.withAlpha(0),
              splashColor: Colors.red.withAlpha(0),
              focusColor: Colors.red.withAlpha(0),
              hoverColor: Colors.red.withAlpha(0),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ViewShareListing(listing)));
              },
              child: Container(
                width: 459,
                height: heightRatio * 459,
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 459,
                      height: (heightRatio * 459),
                      child: CachedNetworkImage(
                        imageUrl: displayImage(),
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    // Positioned(
                    //     bottom: 0,
                    //     right: 0,
                    //     child: Opacity(
                    //       opacity: 0.9,
                    //       child: Container(
                    //         padding: EdgeInsets.symmetric(vertical: 4),
                    //         decoration: BoxDecoration(
                    //             color: Globals.profileYellow,
                    //             borderRadius: BorderRadius.only(
                    //               bottomRight: Radius.circular(24),
                    //               topRight: Radius.circular(12),
                    //               topLeft: Radius.circular(12),
                    //               bottomLeft: Radius.circular(12),
                    //             )),
                    //         child: Row(
                    //           crossAxisAlignment: CrossAxisAlignment.end,
                    //           children: <Widget>[
                    //             SizedBox(width: 4),
                    //             Text(
                    //               "P ${listing.price.round()}",
                    //               // variable
                    //               textAlign: TextAlign.start,
                    //               style: TextStyle(
                    //                   fontFamily: "Lato",
                    //                   fontSize: 14,
                    //                   fontWeight: FontWeight.w600,
                    //                   color: Colors.white),
                    //             ),
                    //             SizedBox(width: 2),
                    //             Text(
                    //               "${priceLabelToString(listing.priceLabel)}",
                    //               // variable
                    //               textAlign: TextAlign.start,
                    //               style: TextStyle(
                    //                   fontFamily: "Lato",
                    //                   fontSize: 13,
                    //                   fontWeight: FontWeight.w600,
                    //                   color: Colors.white),
                    //             ),
                    //             SizedBox(width: 12),
                    //           ],
                    //         ),
                    //       ),
                    //     ))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
