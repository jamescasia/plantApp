import 'package:flutter/material.dart';
import 'package:plantApp/DataModels/Globals.dart';
import 'package:plantApp/Screens/ViewImage.dart';

class ImageTile extends StatefulWidget {
  String imagePath;

  ImageTile(this.imagePath);

  @override
  _ImageTileState createState() => _ImageTileState(this.imagePath);
}

class _ImageTileState extends State<ImageTile> {
  String imagePath;
  _ImageTileState(this.imagePath);
  @override
  Widget build(BuildContext context) {
    return Material(
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
    );
  }
}
