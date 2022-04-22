import 'package:flutter/material.dart';
import 'package:dahar/screens/auth/authenticate.dart';
import 'package:dahar/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:dahar/models/user.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DaharUser?>(context);
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
