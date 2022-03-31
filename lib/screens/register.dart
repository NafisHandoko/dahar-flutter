import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';

class register extends StatelessWidget {
  const register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: 200,
            width: 200,
          ),
          TextField(
            decoration: InputDecoration(
              label: ("Nama"),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              label: ("Email"),
            ),
          ),
          TextField(
            decoration: InputDecoration(
              label: ("Password"),
            ),
          ),
          Container(
            width: Get.width,
            child: ElevatedButton(
              onPressed: () {},
              child: Text("Create Account"),
              style: ElevatedButton.styleFrom(
                primary: color1,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ),
          Text(Or continue with),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.facebook),
                color: color1,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.google),
                color: color1,
                onPressed: () {},
              ),
            ],
          ),
          TextButton(onPressed: (){}, child: Text("already have an account?")),
        ],
      ),
    );
  }
}
