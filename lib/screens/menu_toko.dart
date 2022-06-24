import 'dart:io';

import 'package:dahar/models/auth_user.dart';
import 'package:dahar/models/produk.dart';
import 'package:dahar/models/toko.dart';
import 'package:dahar/screens/add_product.dart';
import 'package:dahar/services/databases/produk_database.dart';
import 'package:dahar/services/databases/toko_database.dart';
import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';
import 'package:dahar/components/back_appbar.dart';
import 'package:dahar/components/navbar.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class MenuToko extends StatelessWidget {
  final id_toko;
  const MenuToko({Key? key, this.id_toko}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Toko>.value(
      initialData: Toko(),
      value: TokoDatabase(uid: id_toko).myToko,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: BackAppBar(
              title: 'Menu Toko',
            )),
        body: MenuTokoProvider(
          id_toko: id_toko,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddProduct()),
            );
          },
          backgroundColor: color1,
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: const NavBar(),
      ),
    );
  }
}

class MenuTokoProvider extends StatelessWidget {
  final id_toko;
  const MenuTokoProvider({Key? key, this.id_toko}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toko = Provider.of<Toko>(context);
    AuthUser user = Provider.of<AuthUser>(context);
    return StreamProvider<List<Produk>>.value(
      initialData: [],
      value: ProdukDatabase(uid: user.uid).produkOnToko,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        color: Colors.white,
        child: ListView(shrinkWrap: true, children: [
          Column(
            children: [
              Stack(children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 10),
                  // margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage("${toko.foto}"),
                          fit: BoxFit.cover),
                      shape: BoxShape.circle,
                      color: color1),
                ),
                Positioned(
                    bottom: 10,
                    right: 0,
                    child: InkWell(
                      onTap: () async {
                        ImagePicker picker = ImagePicker();
                        XFile? image = await picker.pickImage(
                            source: ImageSource.gallery,
                            maxHeight: 400,
                            maxWidth: 400);
                        if (image != null) {
                          TokoDatabase(uid: id_toko).updateTokoFoto(
                              toko.fotoRef ?? '', File(image.path));
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorBlueEdit,
                            boxShadow: [boxshadow2]),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                    ))
              ]),
              Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    '${toko.nama}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => EditNamaDialog(
                                id_toko: id_toko,
                              ));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorBlueEdit,
                          boxShadow: [boxshadow2]),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  )
                ]),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    '${toko.alamat}',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (_) => EditAlamatDialog(
                                id_toko: id_toko,
                              ));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorBlueEdit,
                          boxShadow: [boxshadow2]),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  )
                ]),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                    borderRadius: borderRadius2,
                    color: color1,
                    boxShadow: [boxshadow1]),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/order_list');
                  },
                  child: Text(
                    'Daftar Pesanan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Daganganmu',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          MenuTokoBuilder()
        ]),
      ),
    );
  }
}

class MenuTokoBuilder extends StatelessWidget {
  const MenuTokoBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final produk = Provider.of<List<Produk>>(context);
    return Center(
      child: Wrap(
        spacing: 20,
        runSpacing: 20,
        // children: [
        //   MenuTokoItem(),
        //   MenuTokoItem(),
        //   MenuTokoItem(),
        //   MenuTokoItem(),
        //   MenuTokoItem(),
        // ],
        children: <Widget>[
          for (var item in produk)
            MenuTokoItem(key: ValueKey(item.id), produk: item)
        ],
      ),
    );
  }
}

class MenuTokoItem extends StatelessWidget {
  final produk;
  const MenuTokoItem({Key? key, this.produk}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 145,
          height: 145,
          decoration: BoxDecoration(
              borderRadius: borderRadius1,
              image: DecorationImage(
                  image: NetworkImage('${produk.gambar}'), fit: BoxFit.cover)),
          child: Stack(children: [
            Positioned(
              bottom: 10,
              left: 10,
              child: Row(children: [
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) => EditProdukDialog(
                              id_produk: produk.id,
                              oldGambarRef: produk.gambarRef,
                            ));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorBlueEdit,
                        boxShadow: [boxshadow2]),
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    ProdukDatabase().deleteProduk(produk.id, produk.gambarRef);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorRedDelete,
                        boxShadow: [boxshadow2]),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                )
              ]),
            ),
          ]),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, bottom: 2),
          child: Text(
            '${produk.nama}',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        Text(
          'Rp ${produk.harga}',
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w500, color: color1),
        )
      ],
    );
  }
}

class EditNamaDialog extends StatefulWidget {
  final id_toko;
  const EditNamaDialog({Key? key, this.id_toko}) : super(key: key);

  @override
  State<EditNamaDialog> createState() => _EditNamaDialogState();
}

class _EditNamaDialogState extends State<EditNamaDialog> {
  String newName = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: borderRadius1),
      title: Center(
        child: Text('Ubah Nama Toko',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      ),
      content: Container(
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
              hintText: 'Toko Paijo',
              labelText: 'Nama Toko Baru',
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
                newName = val;
              });
            }),
      ),
      actions: <Widget>[
        // TextButton(
        //   child: Text('CANCEL'),
        //   onPressed: Navigator.of(context).pop,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: borderRadius2,
                // color: color1,
                border: Border.all(color: color1, width: 2),
                // boxShadow: [boxshadow1]
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // maximumSize: Size(10, 10),
                  // alignment: Alignment.centerLeft
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: color1),
                ),
                onPressed: () {
                  // Navigator.of(context).pop(_stars);
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: borderRadius2,
                  color: color1,
                  border: Border.all(color: color1, width: 2),
                  boxShadow: [boxshadow1]),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // maximumSize: Size(10, 10),
                  // alignment: Alignment.centerLeft
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  // Navigator.of(context).pop(_stars);
                  TokoDatabase(uid: widget.id_toko).updateTokoNama(newName);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}

class EditAlamatDialog extends StatefulWidget {
  final id_toko;
  const EditAlamatDialog({Key? key, this.id_toko}) : super(key: key);

  @override
  State<EditAlamatDialog> createState() => _EditAlamatDialogState();
}

class _EditAlamatDialogState extends State<EditAlamatDialog> {
  String newAlamat = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: borderRadius1),
      title: Center(
        child: Text('Ubah Alamat Toko',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      ),
      content: Container(
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
              hintText: 'Jl Merdeka no 80...',
              labelText: 'Alamat Toko Baru',
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
                newAlamat = val;
              });
            }),
      ),
      actions: <Widget>[
        // TextButton(
        //   child: Text('CANCEL'),
        //   onPressed: Navigator.of(context).pop,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: borderRadius2,
                // color: color1,
                border: Border.all(color: color1, width: 2),
                // boxShadow: [boxshadow1]
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // maximumSize: Size(10, 10),
                  // alignment: Alignment.centerLeft
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: color1),
                ),
                onPressed: () {
                  // Navigator.of(context).pop(_stars);
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: borderRadius2,
                  color: color1,
                  border: Border.all(color: color1, width: 2),
                  boxShadow: [boxshadow1]),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // maximumSize: Size(10, 10),
                  // alignment: Alignment.centerLeft
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  // Navigator.of(context).pop(_stars);
                  TokoDatabase(uid: widget.id_toko).updateTokoAlamat(newAlamat);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}

class EditProdukDialog extends StatefulWidget {
  final id_produk, oldGambarRef;
  const EditProdukDialog({Key? key, this.id_produk, this.oldGambarRef})
      : super(key: key);

  @override
  State<EditProdukDialog> createState() => _EditProdukDialogState();
}

class _EditProdukDialogState extends State<EditProdukDialog> {
  String newNama = '';
  String newHarga = '';
  String newDeskripsi = '';
  File? _image;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: borderRadius1),
      title: Center(
        child: Text('Ubah Data Produk',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      ),
      content: ListView(
        shrinkWrap: true,
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
                    newNama = val;
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
                    newHarga = val;
                  });
                }),
          ),
          Container(
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
                  hintText: 'Soto dengan daging ayam dan kuah yang gurih...',
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
                    newDeskripsi = val;
                  });
                }),
          ),
          Text(
            'Gambar Makanan',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          InkWell(
            onTap: () async {
              // final cameras = await availableCameras();
              // final result = await Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //       builder: (context) => Camera(
              //             cameras: cameras,
              //           )),
              // );
              // if (result != null) {
              //   setState(() {
              //     capturedImages = result;
              //   });
              // }
              ImagePicker picker = ImagePicker();
              XFile? image = await picker.pickImage(
                  source: ImageSource.gallery, maxHeight: 600, maxWidth: 600);
              if (image != null) {
                setState(() {
                  _image = File(image.path);
                });
              }
            },
            child: Container(
              margin: const EdgeInsets.only(top: 10),
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                  image: _image != null
                      ? DecorationImage(
                          image: FileImage(_image!), fit: BoxFit.cover)
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
      actions: <Widget>[
        // TextButton(
        //   child: Text('CANCEL'),
        //   onPressed: Navigator.of(context).pop,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: borderRadius2,
                // color: color1,
                border: Border.all(color: color1, width: 2),
                // boxShadow: [boxshadow1]
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // maximumSize: Size(10, 10),
                  // alignment: Alignment.centerLeft
                ),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: color1),
                ),
                onPressed: () {
                  // Navigator.of(context).pop(_stars);
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  borderRadius: borderRadius2,
                  color: color1,
                  border: Border.all(color: color1, width: 2),
                  boxShadow: [boxshadow1]),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // maximumSize: Size(10, 10),
                  // alignment: Alignment.centerLeft
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  // Navigator.of(context).pop(_stars);
                  ProdukDatabase(uid: widget.id_produk).updateProduk(
                      widget.id_produk,
                      int.parse(newHarga),
                      newNama,
                      newDeskripsi,
                      widget.oldGambarRef,
                      _image!);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
