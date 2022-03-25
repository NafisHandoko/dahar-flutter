import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';

class ItemDetail extends StatefulWidget {
  const ItemDetail({Key? key}) : super(key: key);

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.center, children: [
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
              height: 420,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80'),
                      fit: BoxFit.cover)),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: borderRadius1,
                        color: Colors.white,
                      ),
                      child: IconButton(
                          color: color1,
                          onPressed: () {},
                          icon: Icon(Icons.arrow_back_ios_rounded)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: borderRadius1,
                        color: Colors.white,
                      ),
                      child: IconButton(
                          color: color1,
                          onPressed: () {},
                          icon: Icon(Icons.favorite_border_rounded)),
                    )
                  ]),
            )),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 450,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Text('tesaja'),
            )),
        Positioned(
            top: 300,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: borderRadius1,
                  color: color1,
                  boxShadow: [boxshadow1]),
              child: Row(
                children: [
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        '-',
                        style: TextStyle(color: Colors.white),
                      )),
                  const Text(
                    '1',
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        '+',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ))
      ]),
    );
  }
}
