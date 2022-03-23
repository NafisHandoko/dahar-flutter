import 'package:flutter/material.dart';

Color color1 = const Color.fromRGBO(238, 117, 73, 1);
Color color2 = const Color.fromRGBO(255, 214, 200, 1);
BorderRadius borderRadius1 = BorderRadius.circular(20);
BoxShadow boxshadow1 = BoxShadow(
    offset: const Offset(0, 4),
    blurRadius: 20,
    spreadRadius: 0,
    color: color1.withOpacity(0.6));

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(100), child: DaharAppBar()),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text('Hello World')],
          ),
        ),
        bottomNavigationBar: const DaharNavBar());
  }
}

class DaharAppBar extends StatefulWidget {
  const DaharAppBar({Key? key}) : super(key: key);

  @override
  State<DaharAppBar> createState() => _DaharAppBarState();
}

class _DaharAppBarState extends State<DaharAppBar> {
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
                Icons.receipt_outlined,
              ),
              color: color1,
              onPressed: () {},
            ),
            Text(
              "Dahar",
              style: TextStyle(
                  color: color1, fontSize: 32, fontWeight: FontWeight.bold),
            ),
            IconButton(
              // constraints: const BoxConstraints(),
              alignment: Alignment.center,
              icon: const Icon(
                Icons.search_rounded,
              ),
              color: color1,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

class DaharNavBar extends StatefulWidget {
  const DaharNavBar({Key? key}) : super(key: key);

  @override
  State<DaharNavBar> createState() => _DaharNavBarState();
}

class _DaharNavBarState extends State<DaharNavBar> {
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
              Icons.home_filled,
            ),
            color: color1,
            onPressed: () {},
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
            onPressed: () {},
          ),
          IconButton(
            alignment: Alignment.center,
            icon: const Icon(
              Icons.perm_identity_outlined,
            ),
            color: color1,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
