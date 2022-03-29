import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';

class BackAppBar extends StatelessWidget {
  final String title;
  const BackAppBar({Key? key, this.title = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        // color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              // constraints: const BoxConstraints(),
              alignment: Alignment.center,
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
              ),
              color: color1,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            IconButton(
              // constraints: const BoxConstraints(),
              alignment: Alignment.center,
              icon: const Icon(
                Icons.search_rounded,
              ),
              color: Colors.white,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
