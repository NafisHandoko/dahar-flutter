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
        appBar: AppBar(
          title: const Text('Aplikasi Dahar'),
        ),
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
    return Container();
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
    return Container();
  }
}
