import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';
import 'package:dahar/components/back_appbar.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math';

class DetailToko extends StatefulWidget {
  const DetailToko({Key? key}) : super(key: key);

  @override
  State<DetailToko> createState() => _DetailTokoState();
}

class _DetailTokoState extends State<DetailToko> {
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  double distance = 0;
  // late StreamSubscription<Position> positionStream;

  @override
  void initState() {
    checkGps();
    super.initState();
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

      if (haspermission) {
        setState(() {
          //refresh the UI
        });

        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
      distance = calculateDistance(
          position.latitude, position.longitude, -7.551498, 112.230074);
    });

    // LocationSettings locationSettings = LocationSettings(
    //   accuracy: LocationAccuracy.high, //accuracy of the location data
    //   distanceFilter: 100, //minimum distance (measured in meters) a
    //   //device must move horizontally before an update event is generated;
    // );

    // StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
    //       locationSettings: locationSettings).listen((Position position) {
    //       print(position.longitude); //Output: 80.24599079
    //       print(position.latitude); //Output: 29.6593457

    //       long = position.longitude.toString();
    //       lat = position.latitude.toString();

    //       setState(() {
    //         //refresh UI on update
    //       });
    // });
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  Widget _foodItem(String foodImage, String foodName, String foodPrice) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 145,
          height: 145,
          decoration: BoxDecoration(
              borderRadius: borderRadius1,
              image: DecorationImage(
                  image: NetworkImage(foodImage), fit: BoxFit.cover)),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 2),
          child: Text(
            foodName,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          foodPrice,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: color1),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: BackAppBar(
            title: 'Detail Toko',
          )),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        color: Colors.white,
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(bottom: 10),
                // margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1516876437184-593fda40c7ce?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1472&q=80"),
                        fit: BoxFit.cover),
                    shape: BoxShape.circle,
                    color: color1),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: Text(
                  'Warung Bu Supiah',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Supiah Dwi Rijayanti',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'Jl Raden Patah no 30, Desa Kaliwungu, Bandung, Jawa Barat',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: color1, width: 2),
                  borderRadius: borderRadius2,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        '${distance.toStringAsFixed(1)} Km',
                        style: TextStyle(color: color1),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          borderRadius: borderRadius2,
                          color: color1,
                          boxShadow: [boxshadow1]),
                      child: TextButton(
                        child: Text('Posisi Toko',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              )
            ]),
            Center(
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  _foodItem(
                      'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                      'Kari Spesial',
                      'Rp 20000'),
                  _foodItem(
                      'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                      'Kari Spesial',
                      'Rp 20000'),
                  _foodItem(
                      'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                      'Kari Spesial',
                      'Rp 20000'),
                  _foodItem(
                      'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                      'Kari Spesial',
                      'Rp 20000'),
                  _foodItem(
                      'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
                      'Kari Spesial',
                      'Rp 20000')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
