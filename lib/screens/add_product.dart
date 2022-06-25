import 'dart:io';

import 'package:dahar/models/auth_user.dart';
import 'package:dahar/screens/camera.dart';
import 'package:dahar/services/databases/produk_database.dart';
import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';
import 'package:dahar/components/back_appbar.dart';
import 'package:dahar/components/navbar.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<File> capturedImages = [];
  String foodName = '';
  String foodDesc = '';
  String foodPrice = '';

  @override
  Widget build(BuildContext context) {
    AuthUser user = Provider.of<AuthUser>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: BackAppBar(
            title: 'Tambah Dagangan',
          )),
      bottomNavigationBar: const NavBar(),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: borderRadius1,
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: 'Soto Ayam',
                              labelText: 'Nama Makanan',
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
                                foodName = val;
                              });
                            }),
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
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: borderRadius1,
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              fillColor: Colors.white,
                              filled: true,
                              hintText: '12000',
                              labelText: 'Harga',
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
                                foodPrice = val;
                              });
                            }),
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
                            onChanged: (val) {
                              setState(() {
                                foodDesc = val;
                              });
                            }),
                      ),
                      Text(
                        'Gambar Makanan',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      InkWell(
                        onTap: () async {
                          final cameras = await availableCameras();
                          final result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Camera(
                                      cameras: cameras,
                                    )),
                          );
                          if (result != null) {
                            setState(() {
                              capturedImages = result;
                            });
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              image: capturedImages.isNotEmpty
                                  ? DecorationImage(
                                      image: FileImage(capturedImages.last),
                                      fit: BoxFit.cover)
                                  : null,
                              borderRadius: borderRadius1,
                              border: Border.all(color: color1, width: 1)),
                          child: Icon(
                            Icons.camera_alt_rounded,
                            color: color1,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: borderRadius2,
                        color: color1,
                        boxShadow: [boxshadow1]),
                    child: TextButton(
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        ProdukDatabase(uid: user.uid).addProduk(
                            foodName,
                            int.parse(foodPrice),
                            foodDesc,
                            capturedImages.last,
                            0);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
