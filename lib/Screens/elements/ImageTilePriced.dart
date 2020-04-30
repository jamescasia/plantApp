import 'package:flutter/material.dart';
import 'package:plantApp/DataModels/Globals.dart';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/services.dart';

class ImageTilePriced extends StatefulWidget {
  String imagePath;

  ImageTilePriced(this.imagePath);

  @override
  _ImageTilePricedState createState() => _ImageTilePricedState(this.imagePath);
}

class _ImageTilePricedState extends State<ImageTilePriced> {
  String imagePath;
  _ImageTilePricedState(this.imagePath);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(24),
      ),
      child: Container(
          width: 459,
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          )),
    );
  }
}
