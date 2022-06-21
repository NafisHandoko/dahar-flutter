import 'package:dahar/components/back_appbar.dart';
import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';

class Checkout extends StatefulWidget {
  const Checkout({Key? key}) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String dropdownvalue = 'Item 1';
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];
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
                        value: dropdownvalue,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
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
                          hintText:
                              'Soto dengan daging ayam dan kuah yang gurih...',
                          labelText: 'Deskripsi',
                          // prefixIcon: Icon(
                          //   Icons.person,
                          //   color: color1,
                          // ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
            Column()
          ],
        ),
      ),
    );
  }
}
