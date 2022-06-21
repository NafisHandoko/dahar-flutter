import 'dart:developer';

import 'package:dahar/components/back_appbar.dart';
import 'package:dahar/screens/transaction_done.dart';
import 'package:dahar/services/databases/cart_database.dart';
import 'package:dahar/services/databases/order_database.dart';
import 'package:dahar/services/databases/ordercart_database.dart';
import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';

class Checkout extends StatefulWidget {
  final orderCartList, totalPrice, uid;
  const Checkout({Key? key, this.orderCartList, this.totalPrice, this.uid})
      : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String selectedPayment = 'COD';
  var paymentList = [
    'COD',
    'Bank Transfer',
  ];
  String alamat = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // log('orderCartList: ${widget.orderCartList}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: BackAppBar(
            title: 'Checkout',
          )),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment Method',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(90, 108, 234, 0.07),
                            blurRadius: 50,
                            spreadRadius: 0,
                            offset: Offset(12, 26),
                          ),
                        ],
                      ),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: borderRadius1,
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          // prefixIcon: Icon(
                          //   Icons.person,
                          //   color: color1,
                          // ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),

                        // Initial Value
                        value: selectedPayment,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: paymentList.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedPayment = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alamat',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(90, 108, 234, 0.07),
                            blurRadius: 50,
                            spreadRadius: 0,
                            offset: Offset(12, 26),
                          ),
                        ],
                      ),
                      child: TextField(
                          maxLines: 5,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: borderRadius1,
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Tulis alamat disini',
                            // labelText: 'Deskripsi',
                            // prefixIcon: Icon(
                            //   Icons.person,
                            //   color: color1,
                            // ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onChanged: (val) {
                            setState(() {
                              alamat = val;
                            });
                          }),
                    ),
                  ],
                )
              ],
            ),
            Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total'),
                      Text('Rp ${widget.totalPrice}',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700))
                    ]),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: borderRadius2,
                      color: color1,
                      boxShadow: [boxshadow1]),
                  child: TextButton(
                    child: const Text(
                      'Checkout',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      var id_order = await OrderDatabase(uid: widget.uid)
                          .addOrder(alamat, selectedPayment, widget.totalPrice);
                      // for (var orderItem in widget.orderCartList) {
                      //   OrderCartDatabase(uid: widget.uid).addOrderCart(
                      //       order_id,
                      //       orderItem.id_cart,
                      //       orderItem.id_produk,
                      //       orderItem.kuantitas,
                      //       orderItem.total,
                      //       orderItem.status,
                      //       orderItem.id_seller);
                      // }
                      await OrderCartDatabase(uid: widget.uid)
                          .addOrderCart2(widget.orderCartList, id_order);
                      await CartDatabase(uid: widget.uid).deleteAllCart();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TransactionDone(
                                  totalPrice: widget.totalPrice,
                                )),
                      );
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
