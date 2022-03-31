import 'package:dahar/global_styles.dart';
import 'package:flutter/material.dart';

class register extends StatelessWidget {
  const register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Text(
                'REGISTER',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
              ),
              Text('sing up for free',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(90, 108, 234, 0.07),
                      blurRadius: 50,
                      spreadRadius: 0,
                      offset: Offset(12, 26),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius1,
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'username123',
                    labelText: 'Username',
                    prefixIcon: Icon(
                      Icons.person,
                      color: color1,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(90, 108, 234, 0.07),
                      blurRadius: 50,
                      spreadRadius: 0,
                      offset: Offset(12, 26),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius1,
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'example@mail.com',
                    labelText: 'Email',
                    prefixIcon: Icon(
                      Icons.email,
                      color: color1,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(90, 108, 234, 0.07),
                      blurRadius: 50,
                      spreadRadius: 0,
                      offset: Offset(12, 26),
                    ),
                  ],
                ),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: borderRadius1,
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'password123',
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: color1,
                    ),
                    suffixIcon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                //width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: borderRadius1,
                    color: color1,
                    boxShadow: [boxshadow1]),
                child: TextButton(
                  child: const Text(
                    'Create Account',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
