// references : https://www.fluttercampus.com/guide/248/calculate-distance-between-location-google-map-flutter/

// LatLng startLocation = LatLng(-7.5397754, 112.2408845);
// LatLng endLocation = LatLng(-7.551498, 112.230074);
// String googleAPiKey = "AIzaSyAIwRndASqUGuY8O2QaNXkJ5lQgj3lZzj0";

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:math';
import 'package:dahar/global_styles.dart';
import 'package:dahar/components/back_appbar.dart';

class PosisiToko extends StatefulWidget {
  final double tokoLong, tokoLat, userLong, userLat;
  const PosisiToko(
      {Key? key,
      required this.tokoLong,
      required this.tokoLat,
      required this.userLong,
      required this.userLat})
      : super(key: key);

  @override
  _PosisiTokoState createState() => _PosisiTokoState();
}

class _PosisiTokoState extends State<PosisiToko> {
  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();

  // String googleAPiKey = "AIzaSyDma7ThRPGokuU_cJ2Q_qFvowIpK35RAPs";

  // this is our api key
  String googleAPiKey = "AIzaSyAIwRndASqUGuY8O2QaNXkJ5lQgj3lZzj0";

  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {}; //polylines to show direction

  // LatLng startLocation = LatLng(27.6683619, 85.3101895);
  // LatLng endLocation = LatLng(27.6875436, 85.2751138);
  // late LatLng startLocation = LatLng(0, 0);
  // late LatLng endLocation = LatLng(0, 0);
  LatLng startLocation = LatLng(-7.5397754, 112.2408845);
  LatLng endLocation = LatLng(-7.551498, 112.230074);

  double distance = 0.0;

  @override
  void initState() {
    // LatLng startLocation = LatLng(widget.userLat, widget.userLong);
    // LatLng endLocation = LatLng(widget.tokoLat, widget.tokoLong);
    print(startLocation);
    print(endLocation);
    markers.add(Marker(
      //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    markers.add(Marker(
      //add distination location marker
      markerId: MarkerId(endLocation.toString()),
      position: endLocation, //position of marker
      infoWindow: InfoWindow(
        //popup info
        title: 'Destination Point ',
        snippet: 'Destination Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));

    getDirections(); //fetch direction polylines from Google API

    super.initState();
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(startLocation.latitude, startLocation.longitude),
      PointLatLng(endLocation.latitude, endLocation.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      print(result.errorMessage);
    }

    //polulineCoordinates is the List of longitute and latidtude.
    double totalDistance = 0;
    for (var i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += calculateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude);
    }
    print("total distance: $totalDistance");
    // print(totalDistance);

    setState(() {
      distance = totalDistance;
    });

    //add to the list of poly line coordinates
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: BackAppBar(
              title: 'Posisi Toko',
            )),
        body: Stack(children: [
          GoogleMap(
            //Map widget from google_maps_flutter package
            zoomGesturesEnabled: true, //enable Zoom in, out on map
            initialCameraPosition: CameraPosition(
              //innital position in map
              target: startLocation, //initial position
              zoom: 14.0, //initial zoom level
            ),
            markers: markers, //markers to show on map
            polylines: Set<Polyline>.of(polylines.values), //polylines
            mapType: MapType.normal, //map type
            onMapCreated: (controller) {
              //method called when map is created
              setState(() {
                mapController = controller;
              });
            },
          ),
          Positioned(
              bottom: 200,
              left: 50,
              child: Container(
                  child: Card(
                child: Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        "Total Distance: " +
                            distance.toStringAsFixed(2) +
                            " KM",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
              )))
        ]));
  }
}
