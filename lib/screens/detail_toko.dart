import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';
import 'package:dahar/components/back_appbar.dart';

class DetailToko extends StatelessWidget {
  const DetailToko({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: BackAppBar(
            title: 'Detail Toko',
          )),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        color: Colors.white,
        child: ListView(
          children: [
            Column(children: [
              Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(bottom: 10),
                // margin: const EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: NetworkImage(
                            "https://images.unsplash.com/photo-1516876437184-593fda40c7ce?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1472&q=80"),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(100),
                    color: color1),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: Text(
                  'Warung Bu Supiah',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Supiah Dwi Rijayanti',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                child: Text(
                  'Jl Raden Patah no 30, Desa Kaliwungu, Bandung, Jawa Barat',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
