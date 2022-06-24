import 'package:dahar/global_styles.dart';
import 'package:flutter/material.dart';
import 'package:dahar/screens/auth/authenticate.dart';
import 'package:dahar/screens/home.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:dahar/models/auth_user.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkGps();
  }

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

      // if (haspermission) {
      //   return getLocation();
      // }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => GPSDialog());
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthUser?>(context);
    print(user);
    // return either home or auth
    if (user == null) {
      // print("proses keluar");
      return Authenticate();
    } else {
      return Home();
    }
  }
}

class GPSDialog extends StatefulWidget {
  const GPSDialog({Key? key}) : super(key: key);

  @override
  State<GPSDialog> createState() => _GPSDialogState();
}

class _GPSDialogState extends State<GPSDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: borderRadius1),
      title: Center(
        child: Text('Warning!',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: colorRedDelete)),
      ),
      content: Container(
        child: Text(
          'Tolong hidupkan GPS terlebih dahulu!',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
      actions: <Widget>[],
    );
  }
}
