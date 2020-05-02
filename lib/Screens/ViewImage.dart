import 'package:flutter/material.dart';
import 'package:plantApp/DataModels/Globals.dart';
import 'package:plantApp/Screens/elements/ExpandingBottomPanelSelling.dart';

class ViewImage extends StatefulWidget {
  @override
  _ViewImageState createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  bool isExpanded = false;
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
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(0)),
                child: Container(
                    height: Globals.height * 0.70,
                    width: Globals.width,
                    child: Image.asset("assets/images/hydro.png",
                        fit: BoxFit.cover)),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  child: ExpandingBottomPanelSelling(isExpanded))
            ],
          ),
        );
      }),
    ));
  }
}
