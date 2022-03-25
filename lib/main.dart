import 'package:flutter/material.dart';
import 'package:dahar/screens/home.dart';
import 'package:dahar/screens/item_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dahar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/item_detail',
      routes: {
        '/': (context) => const Home(),
        '/item_detail': (context) => const ItemDetail()
      },
    );
  }
}
