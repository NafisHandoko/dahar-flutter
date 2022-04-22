import 'package:flutter/material.dart';
import 'package:dahar/screens/auth/authenticate.dart';
import 'package:dahar/screens/home.dart';
import 'package:provider/provider.dart';
import 'package:dahar/models/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<DaharUser?>(context);
    print(user);
    // return either home or auth
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
