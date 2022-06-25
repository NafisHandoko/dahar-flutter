import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dahar/models/auth_user.dart';
import 'package:dahar/models/toko.dart';
import 'package:dahar/screens/detail_toko.dart';
import 'package:dahar/screens/item_detail.dart';
import 'package:dahar/screens/maps/networking.dart';
import 'package:dahar/services/databases/produk_database.dart';
import 'package:dahar/services/databases/rating_database.dart';
import 'package:dahar/services/databases/toko_database.dart';
import 'package:dahar/services/toko_distance.dart';
import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';
import 'package:dahar/components/navbar.dart';
import 'package:dahar/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dahar/models/produk.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(100), child: DaharAppBar()),
        body: Container(
          // padding: const EdgeInsets.only(right: 30, left: 30),
          color: Colors.white,
          child: ListView(
            children: const [Popular(), Closest()],
          ),
        ),
        bottomNavigationBar: const NavBar());
  }
}

class DaharAppBar extends StatefulWidget {
  const DaharAppBar({Key? key}) : super(key: key);

  @override
  State<DaharAppBar> createState() => _DaharAppBarState();
}

class _DaharAppBarState extends State<DaharAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        // color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              // constraints: const BoxConstraints(),
              alignment: Alignment.center,
              icon: const Icon(
                Icons.receipt_outlined,
              ),
              color: color1,
              onPressed: () {
                Navigator.pushNamed(context, '/order_history');
              },
            ),
            Text(
              "Dahar",
              style: TextStyle(
                  color: color1, fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// GestureDetector _popularItem(context, String foodImage, String foodTitle,
//     String foodSeller, int foodPrice, double foodRating) {
//   return PopularItem();
// }

class PopularItem extends StatefulWidget {
  // final foodImage, foodTitle, foodPrice, foodRating, foodDesc;
  // final DocumentReference foodSellerId;
  final produk;
  const PopularItem({Key? key, this.produk}) : super(key: key);

  @override
  State<PopularItem> createState() => _PopularItemState();
}

class _PopularItemState extends State<PopularItem> {
  num rating = 0;
  Toko? toko;
  @override
  initState() {
    super.initState();
    widget.produk.id_toko.get().then((value) {
      setState(() {
        // foodSellerName = value.get('nama');
        toko = Toko(
            nama: value.get('nama'),
            alamat: value.get('alamat'),
            lat: value.get('lat'),
            long: value.get('long'),
            foto: value.get('foto'));
      });
    });
  }

  getRating() async {
    var ratingData = await RatingDatabase().getRatingProduk(widget.produk.id);
    if (mounted) {
      setState(() {
        rating = ratingData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    getRating();
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, '/item_detail');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ItemDetail(
                    produk: widget.produk,
                    toko: toko,
                  )),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 165,
              height: 145,
              decoration: BoxDecoration(
                  borderRadius: borderRadius1,
                  image: DecorationImage(
                      image: NetworkImage(widget.produk.gambar),
                      fit: BoxFit.cover)),
              child: Stack(children: [
                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: borderRadius1,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    child: Text(
                      'Rp ${widget.produk.harga}',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    decoration: BoxDecoration(
                      borderRadius: borderRadius1,
                      color: Colors.white.withOpacity(0.8),
                    ),
                    child: Row(children: [
                      Icon(
                        Icons.star,
                        color: colorStar,
                      ),
                      Text(
                        '${rating}',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ]),
                  ),
                )
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5, bottom: 2),
              child: Text(
                widget.produk.nama,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              '${toko?.nama}',
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w500, color: color1),
            )
          ],
        ),
      ),
    );
  }
}

class Popular extends StatefulWidget {
  const Popular({Key? key}) : super(key: key);

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  @override
  Widget build(BuildContext context) {
    AuthUser user = Provider.of<AuthUser>(context);
    return StreamProvider<List<Produk>>.value(
      initialData: [],
      value: ProdukDatabase(uid: user.uid).produk,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10, left: 25),
            child: const Text(
              'Produk',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 194,
            child: PopularBuilder(),
          )
        ],
      ),
    );
  }
}

class PopularBuilder extends StatelessWidget {
  const PopularBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final produk = Provider.of<List<Produk>>(context);
    // log('$produk');
    // produk.forEach((item) async {
    //   log(item.deskripsi);
    //   var x = await item.id_toko.get();
    //   var y =
    //       await FirebaseFirestore.instance.doc('toko/' + item.id_toko.id).get();
    //   log("${(x.get('nama'))}");
    // });

    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        scrollDirection: Axis.horizontal,
        itemCount: produk.length,
        itemBuilder: (context, index) {
          return PopularItem(produk: produk[index]);
        });

    // log('${produk!.docs}');
    // List produkData = produk?.docs ?? [];
    // log('${produkData.length}');
    // for (var item in produkData) {
    //   log('${(item.get("harga"))}');
    // }
    // return ListView(
    //   // padding: const EdgeInsets.only(left: 25),
    //   padding: const EdgeInsets.symmetric(horizontal: 25),
    //   scrollDirection: Axis.horizontal,
    //   children: [
    //     // Image.network('https://picsum.photos/250?image=9'),
    //     _popularItem(
    //         context,
    //         'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
    //         'Kari Spesial',
    //         'Warung Bu Supiah',
    //         20000,
    //         4.2),
    //     _popularItem(
    //         context,
    //         'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
    //         'Kari Spesial',
    //         'Warung Bu Supiah',
    //         20000,
    //         4.2),
    //     _popularItem(
    //         context,
    //         'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
    //         'Kari Spesial',
    //         'Warung Bu Supiah',
    //         20000,
    //         4.2)
    //   ],
    // );
  }
}

// GestureDetector _closestItem(
//     context, String foodImage, String foodSeller, String foodDistance) {
//   return ClosestItem();
// }

class ClosestItem extends StatefulWidget {
  final toko;
  const ClosestItem({Key? key, this.toko}) : super(key: key);

  @override
  State<ClosestItem> createState() => _ClosestItemState();
}

class _ClosestItemState extends State<ClosestItem> {
  double? distance;

  @override
  void initState() {
    getDistance();
    super.initState();
  }

  getDistance() async {
    var tokoDist =
        await TokoDistance(tokoLat: widget.toko.lat, tokoLong: widget.toko.long)
            .checkGps();
    if (mounted) {
      setState(() {
        distance = tokoDist;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(context, '/detail_toko');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DetailToko(
                    toko: widget.toko,
                  )),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        height: 100,
        decoration: BoxDecoration(
            borderRadius: borderRadius1,
            image: DecorationImage(
                image: NetworkImage(widget.toko.foto), fit: BoxFit.cover)),
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius1,
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          Positioned(
            bottom: 15,
            left: 15,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: Text(widget.toko.nama,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white)),
              ),
              Text(
                '${distance?.toStringAsFixed(1)} Km',
                style: TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w600, color: color2),
              )
            ]),
          )
        ]),
      ),
    );
  }
}

class Closest extends StatefulWidget {
  const Closest({Key? key}) : super(key: key);

  @override
  State<Closest> createState() => _ClosestState();
}

class _ClosestState extends State<Closest> {
  @override
  Widget build(BuildContext context) {
    AuthUser user = Provider.of<AuthUser>(context);
    return StreamProvider<List<Toko>>.value(
      initialData: [],
      value: TokoDatabase(uid: user.uid).toko,
      child: Container(
        margin: const EdgeInsets.only(left: 25, right: 25, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: const Text(
                'Toko',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
            ),
            ClosestBuilder()
          ],
        ),
      ),
    );
  }
}

class ClosestBuilder extends StatelessWidget {
  const ClosestBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toko = Provider.of<List<Toko>>(context);
    // log('${toko.first.nama}');
    // toko.forEach((item) {
    //   log('${item.nama}');
    // });
    return Column(
      children: <Widget>[for (var item in toko) ClosestItem(toko: item)],
    );
  }
}
