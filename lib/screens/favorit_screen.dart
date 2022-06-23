import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dahar/models/auth_user.dart';
import 'package:dahar/models/favorit.dart';
import 'package:dahar/models/produk.dart';
import 'package:dahar/services/databases/cart_database.dart';
import 'package:dahar/services/databases/favorit_database.dart';
import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';
import 'package:dahar/components/navbar.dart';
import 'package:dahar/components/back_appbar.dart';
import 'package:provider/provider.dart';

class FavoritScreen extends StatelessWidget {
  const FavoritScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthUser user = Provider.of<AuthUser>(context);
    return StreamProvider<List<Favorit>>.value(
      initialData: [],
      value: FavoritDatabase(uid: user.uid).favorit,
      child: Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: BackAppBar(
                title: 'Favorit',
              )),
          body: FavoritBuilder(
            uid: user.uid,
          ),
          bottomNavigationBar: const NavBar()),
    );
  }
}

class FavoritBuilder extends StatelessWidget {
  final uid;
  const FavoritBuilder({Key? key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favorit = Provider.of<List<Favorit>>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      color: Colors.white,
      // child: ListView(
      //   children: [FavoritItem(), FavoritItem(), FavoritItem()],
      // ),
      child: ListView.builder(
          itemCount: favorit.length,
          itemBuilder: (context, index) {
            return FavoritItem(
              key: ValueKey(favorit[index].id),
              favorit: favorit[index],
              uid: uid,
            );
          }),
    );
  }
}

class FavoritItem extends StatefulWidget {
  final favorit, uid;
  const FavoritItem({Key? key, this.favorit, this.uid}) : super(key: key);

  @override
  State<FavoritItem> createState() => _FavoritItemState();
}

class _FavoritItemState extends State<FavoritItem> {
  String? foodName;
  String? foodSeller;
  int? harga;
  String? foodImage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.favorit.id_produk.get().then((doc) {
      setState(() {
        foodName = doc.get('nama');
        harga = doc.get('harga');
        foodImage = doc.get('gambar');
      });
      var tokoRef =
          FirebaseFirestore.instance.doc('toko/' + doc.get('id_toko').id).get();
      tokoRef.then((val) {
        setState(() {
          foodSeller = val.get('nama');
        });
      });
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
                      image: NetworkImage(
                        '$foodImage',
                      ),
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
                        Text('Rp $harga',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                        Container(
                          // margin: const EdgeInsets.only(bottom: 20),
                          // decoration: BoxDecoration(
                          //   border: Border.all(color: color1, width: 2),
                          //   borderRadius: borderRadius2,
                          // ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: () {
                                    // CartDatabase().deleteCart(widget.cart.id);
                                    CartDatabase(uid: widget.uid).addCart(
                                        1, widget.favorit.id_produk.id);
                                  },
                                  child: Icon(
                                    Icons.shopping_cart,
                                    color: color1,
                                    size: 30,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: InkWell(
                                    onTap: () {
                                      FavoritDatabase(
                                              uid: widget.uid,
                                              id_produk:
                                                  widget.favorit.id_produk.id)
                                          .deleteFavorit();
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: colorRedDelete,
                                      size: 30,
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
