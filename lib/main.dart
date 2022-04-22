import 'package:dahar/screens/add_product.dart';
import 'package:dahar/screens/wrapper.dart';
// import 'package:dahar/screens/camera.dart';
import 'package:flutter/material.dart';
import 'package:dahar/screens/home.dart';
import 'package:dahar/screens/item_detail.dart';
import 'package:dahar/screens/order_history.dart';
import 'package:dahar/screens/detail_toko.dart';
import 'package:dahar/screens/menu_toko.dart';
// import 'package:dahar/screens/auth/register.dart';
import 'package:dahar/screens/transaction_done.dart';
// import 'package:dahar/screens/auth/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:dahar/models/user.dart';
import 'package:dahar/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<DaharUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        title: 'Dahar',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const Wrapper(),
          '/home': (context) => const Home(),
          '/item_detail': (context) => const ItemDetail(),
          '/order_history': (context) => const OrderHistory(),
          '/detail_toko': (context) => const DetailToko(),
          '/menu_toko': (context) => const MenuToko(),
          // '/register': (context) => const Register(),
          '/add_product': (context) => const AddProduct(),
          '/transaction_done': (context) => const TransactionDone(),
          // '/login': (context) => const Login(),
          // '/camera': (context) => const Camera()
        },
      ),
    );
  }
}
