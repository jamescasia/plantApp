import 'package:flutter/material.dart';
import 'package:plantApp/DataModels/Globals.dart';
import 'package:plantApp/Screens/ViewImage.dart';

class ImageTile extends StatefulWidget {
  String imagePath;
  int index;

  ImageTile(this.imagePath, this.index);

  @override
  _ImageTileState createState() => _ImageTileState(this.imagePath, this.index);
}

class _ImageTileState extends State<ImageTile> {
  String imagePath;
  int index;
  _ImageTileState(this.imagePath, this.index);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.only(top:(index == 0 || index == 1)?20: 0),
      // padding:  EdgeInsets.only( top:( index == 0 || index == 1)? 20: 0.0),
      child: Material(
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (BuildContext context) => ViewImage()));
            },
            child: Container(
                width: 459,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                )),
          ),
        ),
      ),
    );
  }
}
