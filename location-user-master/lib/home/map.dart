import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:seek4care_user/home/nurseForm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class map extends StatefulWidget {
  static const String id = 'map.dart';

  @override
  _mapState createState() => _mapState();
}

class _mapState extends State<map> {
  LatLng add;
  Completer<GoogleMapController> _controller = Completer();

  // default Camera Position
  static final CameraPosition _kJaipur = CameraPosition(
    target: LatLng(26.9124, 75.7873),
    zoom: 14.0,
  );

  static const String markerId = 'balloonId';
  Marker balloon = Marker(
    markerId: MarkerId(markerId),
    position: LatLng(26.9124, 75.7873),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onTap: (LatLng) {
          print(LatLng);
          _newMarkLocation(LatLng);
          setState(() {
            balloon = Marker(
              markerId: MarkerId('initMark'),
              position: LatLng,
            );
          });
        },
        initialCameraPosition: _kJaipur,
        markers: Set.from([balloon]),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // pop up a alert dialog box
          showDialog(
              context: context,
              child: new AlertDialog(
                title: new Text("Select Location"),
                content: new Text("Do you want to select this location ?"),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Yes'),
                    onPressed: () async {
                      var location = Map();
                      location['lat'] = balloon.position.latitude.toString();
                      location['long'] = balloon.position.longitude.toString();

                      print('location is $location');
                      final slValues = await SharedPreferences.getInstance();
                      setState(() {
                        // store the location in shared preferences
                        slValues.setString('lat', location['lat']);
                        slValues.setString('long', location['long']);
                      });

                      Navigator.pushNamed(context, nurseForm.id);
                      print('head to patient form ');
                    },
                  ),
                  FlatButton(
                    child: Text('No'),
                    onPressed: () {
                      Navigator.pop(context, map);
                    },
                  )
                ],
              ));
        }, // Mark Location
        label: Text('Select Location'),
        icon: Icon(Icons.add_location),
      ),
    );
  }

  Future<void> _newMarkLocation(LatLng) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng,
        tilt: 30.440717697143555,
        zoom: 18.151926040649414)));
  }
}