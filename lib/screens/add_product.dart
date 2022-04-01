import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';
import 'package:dahar/components/back_appbar.dart';
import 'package:dahar/components/navbar.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100),
          child: BackAppBar(
            title: 'Tambah Dagangan',
          )),
      bottomNavigationBar: const NavBar(),
      body: Container(
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
                    ),
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
                    ),
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
                  Text(
                    'Gambar Makanan',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
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
                // margin: const EdgeInsets.only(top: 10),
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
                  onPressed: () {},
                ),
              ),
            ]),
      ),
    );
  }
}
