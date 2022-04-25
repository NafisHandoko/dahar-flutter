import 'package:flutter/material.dart';
import 'package:dahar/screens/auth/login.dart';
import 'package:dahar/screens/auth/register.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    // print("masuk authenticate");
    if (showSignIn) {
      return Login(
        toggleView: toggleView,
      );
    } else {
      return Register(
        toggleView: toggleView,
      );
    }
    // return Login();
  }
}
