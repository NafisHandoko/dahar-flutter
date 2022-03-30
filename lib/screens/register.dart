import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';

class register extends StatelessWidget {
  const register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var name = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            child: TextField(
              controller: name,
              decoration: InputDecoration(
                hintText: "name",
                prefixIcon: Icon(Icons.person, color: color1),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 10,
                    color: color1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    width: 10,
                    color: color1,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
