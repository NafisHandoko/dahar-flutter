import 'package:flutter/material.dart';

class register extends StatelessWidget {
  const register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Text('Register'),
              Text('sing up for free'),
              Container(),
              Container(),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
