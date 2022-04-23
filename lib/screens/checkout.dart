import 'package:dahar/components/back_appbar.dart';
import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';

class checkout extends StatelessWidget {
  const checkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: BackAppBar(
          title: 'Checkout',
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Text(
            'Payment Method',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'COD',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Text(
                'Change',
                style: TextStyle(
                    fontSize: 14, color: color1, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 20),
          Text(
            'Address',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Jl Kian Santang no 15, Keraton Utama,\n Kerajaan Pajajaran',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Text(
                'Change',
                style: TextStyle(
                    fontSize: 14, color: color1, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 400),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              Text(
                'Rp. 78.000',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: borderRadius1,
                    color: color1,
                    boxShadow: [boxshadow1]),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Checkout',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
        ]),
      ),
    );
  }
}
