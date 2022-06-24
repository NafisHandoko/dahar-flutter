import 'dart:async';
// import 'package:dahar/screens/wrapper.dart';
import 'package:dahar/global_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// class MyApp extends StatelessWidget {
// @override
// Widget build(BuildContext context) {
// 	return MaterialApp(
// 	title: 'Splash Screen',
// 	theme: ThemeData(
// 		primarySwatch: Colors.green,
// 	),
// 	home: Splash(),
// 	debugShowCheckedModeBanner: false,
// 	);
// }
// }

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 5),
        // () => Navigator.pushReplacement(
        //     context, MaterialPageRoute(builder: (context) => Wrapper()))
        () => Navigator.pushReplacementNamed(context, '/'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: Colors.white,
            // child: FlutterLogo(size: MediaQuery.of(context).size.height)
            child: Image(image: AssetImage('assets/logo.png')),
          ),
          Container(
            color: Colors.white,
            child: Center(
                child: SpinKitSquareCircle(
              color: color1,
              size: 50.0,
            )),
          ),
        ],
      ),
    );
  }
}

// class SecondScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("GeeksForGeeks")),
//       body: Center(
//           child: Text(
//         "Home page",
//         textScaleFactor: 2,
//       )),
//     );
//   }
// }
