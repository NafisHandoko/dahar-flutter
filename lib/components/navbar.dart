import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: const Offset(0, 20),
            blurRadius: 90,
            spreadRadius: 0,
            color: Colors.black.withOpacity(0.25))
      ]),
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      // color: Colors.blue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            alignment: Alignment.center,
            icon: const Icon(
              Icons.home_outlined,
            ),
            color: color1,
            onPressed: () {
              Navigator.pushNamed(context, '/home');
            },
          ),
          IconButton(
            alignment: Alignment.center,
            icon: const Icon(
              Icons.favorite_border,
            ),
            color: color1,
            onPressed: () {},
          ),
          IconButton(
            alignment: Alignment.center,
            icon: const Icon(
              Icons.shopping_cart_outlined,
            ),
            color: color1,
            onPressed: () {
              Navigator.pushNamed(context, '/cart_screen');
            },
          ),
          IconButton(
            alignment: Alignment.center,
            icon: const Icon(
              Icons.perm_identity_outlined,
            ),
            color: color1,
            onPressed: () {
              Navigator.pushNamed(context, '/your_profile');
            },
          ),
        ],
      ),
    );
  }
}
