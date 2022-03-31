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
              Text(
                'REGISTER',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              Text('sing up for free',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
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
