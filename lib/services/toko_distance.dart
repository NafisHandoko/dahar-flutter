import 'package:dahar/screens/maps/networking.dart';
import 'package:geolocator/geolocator.dart';

class TokoDistance {
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  late double userLong, userLat;
  double? distance;
  var data;

  final double? tokoLong;
  final double? tokoLat;
  TokoDistance({this.tokoLat, this.tokoLong});

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        return getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();
    double? jarak = await streetDistance(
        position.latitude, position.longitude, tokoLat, tokoLong);
    //refresh UI
    userLong = position.longitude;
    userLat = position.latitude;
    if (jarak != null) {
      distance = (jarak / 1000);
    } else {
      distance = 0;
    }
    return distance;
  }

  Future<double?> streetDistance(startLat, startLng, endLat, endLng) async {
    NetworkHelper network = NetworkHelper(
      startLat: startLat,
      startLng: startLng,
      endLat: endLat,
      endLng: endLng,
    );

    try {
      // getData() returns a json Decoded data
      data = await network.getData();

      // get distance and print
      return data['features'][0]['properties']['summary']['distance'];
    } catch (e) {
      print(e);
    }
  }
}
