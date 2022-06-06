import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';
import 'package:dahar/components/navbar.dart';
import 'package:dahar/components/back_appbar.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: BackAppBar(
            title: 'Cart',
          )),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        color: Colors.white,
        child: Column(
          children: [
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [CartItem()],
            ),
            Container()
          ],
        ),
      ),
    );
  }
}

class CartItem extends StatefulWidget {
  const CartItem({Key? key}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  int _cartCount = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 15),
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                  borderRadius: borderRadius1,
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80'),
                      fit: BoxFit.cover)),
            ),
            Expanded(
              // color: Colors.amberAccent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    'Sate Asli Madura',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Rumah Sate Pak Yen',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: color1),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Rp 20.000',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                        Container(
                          // margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: color1, width: 2),
                            borderRadius: borderRadius2,
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: borderRadius2,
                                      color: color1,
                                      boxShadow: [boxshadow1]),
                                  child: Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              _cartCount -= 1;
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 7),
                                            child: const Text(
                                              '-',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          )),
                                      Text(
                                        '$_cartCount',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            setState(() {
                                              _cartCount += 1;
                                            });
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: const Text(
                                              '+',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.delete,
                                      color: colorRedDelete,
                                      size: 20,
                                    ),
                                  ),
                                )
                              ]),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ]),
    );
  }
}
