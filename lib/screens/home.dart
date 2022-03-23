import 'package:flutter/material.dart';

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
    );
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
