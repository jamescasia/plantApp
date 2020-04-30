import 'package:flutter/material.dart';
import 'package:plantApp/DataModels/Globals.dart';

class ExpandingBottomPanelSelling extends StatefulWidget {
  bool isExpanded;
  ExpandingBottomPanelSelling(this.isExpanded);
  @override
  _ExpandingBottomPanelSellingState createState() =>
      _ExpandingBottomPanelSellingState(this.isExpanded);
}

class _ExpandingBottomPanelSellingState extends State<ExpandingBottomPanelSelling> {
  bool isExpanded = false;
  _ExpandingBottomPanelSellingState(this.isExpanded);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
          height: (isExpanded) ? Globals.height * 0.59 : Globals.height * 0.38,
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
                        left: Globals.dwidth * 24, bottom: Globals.dwidth * 8),
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
                          height: 3* Globals.dheight,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                    borderRadius: BorderRadius.all(Radius.circular(8))),
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
                        margin: EdgeInsets.only(bottom: Globals.dwidth * 4),
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
    );
  }
}
