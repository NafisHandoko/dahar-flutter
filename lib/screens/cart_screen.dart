import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dahar/models/cart.dart';
import 'package:dahar/models/auth_user.dart';
import 'package:dahar/screens/checkout.dart';
import 'package:dahar/screens/checkout2.dart';
import 'package:dahar/services/databases/cart_database.dart';
import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';
import 'package:dahar/components/navbar.dart';
import 'package:dahar/components/back_appbar.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthUser user = Provider.of<AuthUser>(context);
    return StreamProvider<List<Cart>>.value(
      initialData: [],
      value: CartDatabase(uid: user.uid).cart,
      child: Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: BackAppBar(
                title: 'Cart',
              )),
          body: CartProvider(uid: user.uid),
          bottomNavigationBar: const NavBar()),
    );
  }
}

class CartProvider extends StatelessWidget {
  final uid;
  const CartProvider({Key? key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<List<Cart>>(context);
    // return ListView(
    //     // scrollDirection: Axis.vertical,
    //     // shrinkWrap: true,
    //     children: [CartItem(), CartItem()]);
    // var produk;
    // for (var cartItem in cart) {
    //   produk = cartItem.id_produk.get().then((value) {
    //     // return value.get('harga');
    //     log('data value: ${value.get('harga')}');
    //     // total = value.get('harga');
    //   });
    //   // log('data total: $produk');
    // }
    // cart.asMap().forEach((index, val) {
    //   log('$index ${val.kuantitas}');
    // });

    return CartBuilder(
      cart: cart,
      uid: uid,
    );
  }
}

class CartBuilder extends StatefulWidget {
  final cart, uid;
  const CartBuilder({Key? key, this.cart, this.uid}) : super(key: key);

  @override
  State<CartBuilder> createState() => _CartBuilderState();
}

class _CartBuilderState extends State<CartBuilder> {
  num totalCart = 0;
  var orderCartList = [];

  // @override
  // void initState() {
  //   super.initState();
  //   // widget.cart.forEach((cartItem) {
  //   //   log('di foreach: $cartItem');
  //   //   // cartItem.id_produk.get().then((val) {
  //   //   //   setState(() {
  //   //   //     totalCart = val.get('harga');
  //   //   //   });
  //   //   // });
  //   //   // log("data x: ${x.get('harga')}");
  //   // });
  //   // getTotalCart();
  // }

  getTotalCart() {
    setState(() {
      totalCart = 0;
    });
    // num sum = mylist.fold(0, (p, c) => p + c);
    // return sum;
    // for (var harga in mylist) {
    //   if (harga != null) {
    //     setState(() {
    //       totalCart += harga;
    //     });
    //   }
    // }
    for (var orderItem in orderCartList) {
      // log('data orderItem: $orderItem');
      setState(() {
        totalCart += orderItem?['total'] ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      orderCartList.length = widget.cart.length;
    });
    widget.cart.asMap().forEach((index, cartItem) {
      // log('yukyuk $index ${cartItem.kuantitas}');
      cartItem.id_produk.get().then((val) {
        // log("harga: ${val.get('harga')}");
        setState(() {
          // mylist[index] = val.get('harga') * cartItem.kuantitas;

          // mylist[index].id_cart = cartItem.id;
          // mylist[index].id_produk = cartItem.id_produk;
          // mylist[index].kuantitas = cartItem.kuantitas;
          // mylist[index].total = val.get('harga') * cartItem.kuantitas;
          // mylist[index].status = 0;
          // mylist[index].id_seller = val.get('id_toko');
          // mylist[index].id_buyer = widget.uid;
          orderCartList[index] = {
            // 'id_cart': cartItem.id,
            'id_produk': cartItem.id_produk,
            'kuantitas': cartItem.kuantitas,
            'total': val.get('harga') * cartItem.kuantitas,
            'status': 0,
            'id_seller': val.get('id_toko'),
            'id_buyer': widget.uid,
          };
        });
      });
    });
    getTotalCart();
    // log('data mylist $mylist');
    return Stack(children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        color: Colors.white,
        child: ListView.builder(
            itemCount: widget.cart.length,
            itemBuilder: (context, index) {
              return CartItem(
                  key: ValueKey(widget.cart[index].id),
                  cart: widget.cart[index]);
            }),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          padding:
              const EdgeInsets.only(right: 25, left: 25, top: 30, bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
            color: color2,
          ),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Total'),
              Text('Rp ${totalCart}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700))
            ]),
            Container(
              margin: const EdgeInsets.only(top: 20),
              // width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: borderRadius2,
                  color: color1,
                  boxShadow: [boxshadow1]),
              child: TextButton(
                child: const Text(
                  'Checkout',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Checkout(
                              orderCartList: orderCartList,
                              totalPrice: totalCart,
                              uid: widget.uid,
                            )),
                  );
                },
              ),
            )
          ]),
        ),
      )
    ]);
  }
}

class CartItem extends StatefulWidget {
  final cart;
  const CartItem({Key? key, this.cart}) : super(key: key);

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int _cartCount;
  String? foodName;
  int? foodPrice;
  String? foodSeller;
  String? foodImage;
  @override
  initState() {
    super.initState();
    widget.cart.id_produk.get().then((value) {
      setState(() {
        foodName = value.get('nama');
        foodImage = value.get('gambar');
        foodPrice = value.get('harga');
      });
      var tokoRef = FirebaseFirestore.instance
          .doc('toko/' + value.get('id_toko').id)
          .get();
      tokoRef.then((val) {
        setState(() {
          foodSeller = val.get('nama');
        });
      });
    });
    setState(() {
      _cartCount = widget.cart.kuantitas;
    });
  }

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
                      image: NetworkImage('$foodImage'), fit: BoxFit.cover)),
            ),
            Expanded(
              // color: Colors.amberAccent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '$foodName',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    '$foodSeller',
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
                        Text('Rp $foodPrice',
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
                                            CartDatabase().updateCart(
                                                widget.cart.id, _cartCount);
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
                                            CartDatabase().updateCart(
                                                widget.cart.id, _cartCount);
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
                                    onTap: () {
                                      CartDatabase().deleteCart(widget.cart.id);
                                    },
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
