import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plantApp/DataModels/Globals.dart';

class MapFragment extends StatefulWidget {
  double lat;
  double lang;
  MapFragment(this.lat, this.lang);
  @override
  _MapFragmentState createState() => _MapFragmentState(this.lat, this.lang);
}

class _MapFragmentState extends State<MapFragment> {
  double lat;
  double lang;

  _MapFragmentState(this.lat, this.lang);
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition initialPosition = CameraPosition(
    target: LatLng(0, 0),
    zoom: 16,
  );
  // CLASS MEMBER, MAP OF MARKS

  @override
  Widget build(BuildContext context) {
    initialPosition = CameraPosition(
      target: LatLng(lat, lang),
      zoom: 16,
    );
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      child: Container(
          width: Globals.width * 0.99,
          height: Globals.height * 0.7,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(40))),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  child: Container(
                    width: Globals.width * 0.99,
                    height: Globals.height * 0.7,
                    color: Colors.white,
                    padding: EdgeInsets.all(Globals.dwidth * 8),
                    child: GoogleMap(
                      markers: Set<Marker>.of([
                        Marker(
                            markerId: MarkerId("1"),
                            position: LatLng(lat, lang))
                      ]),
                      mapType: MapType.normal,
                      initialCameraPosition: initialPosition,
                      onMapCreated: (GoogleMapController controller) {
                        _controller.complete(controller);
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                top: Globals.dwidth * 13,
                right: Globals.dwidth * 13,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Opacity(
                    opacity: 0.7,
                    child: Container(
                        width: Globals.dwidth * 26,
                        height: Globals.dwidth * 26,
                        decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius:
                                BorderRadius.all(Radius.circular(300))),
                        child: Center(
                          child: FaIcon(FontAwesomeIcons.times,
                              size: Globals.dwidth * 20, color: Colors.white),
                        )),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(initialPosition));
  }
}
