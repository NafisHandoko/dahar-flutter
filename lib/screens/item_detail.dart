import 'package:dahar/models/auth_user.dart';
import 'package:dahar/models/favorit.dart';
import 'package:dahar/services/databases/cart_database.dart';
import 'package:dahar/services/databases/favorit_database.dart';
import 'package:dahar/services/databases/rating_database.dart';
import 'package:dahar/services/toko_distance.dart';
import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';
import 'package:provider/provider.dart';

class ItemDetail extends StatefulWidget {
  final produk, toko;
  const ItemDetail({Key? key, this.produk, this.toko}) : super(key: key);

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  double? distance;
  int _cartCount = 1;
  num rating = 0;

  @override
  void initState() {
    getRating();
    getDistance();
    super.initState();
  }

  getRating() async {
    var ratingData = await RatingDatabase().getRatingProduk(widget.produk.id);
    if (mounted) {
      setState(() {
        rating = ratingData;
      });
    }
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
    AuthUser user = Provider.of<AuthUser>(context);
    return StreamProvider<List<Favorit>>.value(
      initialData: [],
      value:
          FavoritDatabase(uid: user.uid, id_produk: widget.produk.id).isFavorit,
      child: Scaffold(
        body: Stack(alignment: Alignment.center, children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
                height: 420,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.produk.gambar),
                        fit: BoxFit.cover)),
                child: NavButton(id_produk: widget.produk.id, uid: user.uid),
              )),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 35),
                height: 460,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.produk.nama,
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 24),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: colorStar,
                            ),
                            Text(
                              '${rating}',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            margin: const EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(widget.toko.foto),
                                    fit: BoxFit.cover),
                                shape: BoxShape.circle,
                                color: color1),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 3),
                                child: Text(
                                  widget.toko.nama,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              Text('${distance?.toStringAsFixed(1)} Km')
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 180,
                      margin: const EdgeInsets.only(top: 15),
                      child: ListView(padding: EdgeInsets.zero, children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: const Text(
                            'Description',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        Text(
                          // '''Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?''',
                          widget.produk.deskripsi,
                          softWrap: true,
                        )
                      ]),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: borderRadius2,
                          color: color1,
                          boxShadow: [boxshadow1]),
                      child: TextButton(
                        child: const Text(
                          'Add to Cart',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          AuthUser user =
                              Provider.of<AuthUser>(context, listen: false);
                          await CartDatabase(uid: user.uid)
                              .addCart(_cartCount, widget.produk.id);
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: color1, width: 3),
                        borderRadius: borderRadius2,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                  borderRadius: borderRadius2,
                                  color: color1,
                                  boxShadow: [boxshadow1]),
                              child: TextButton(
                                child: const Text(
                                  'Buy',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {},
                              ),
                            ),
                            Text(
                              'Rp ${widget.produk.harga}',
                              style: TextStyle(
                                  color: color1,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            )
                          ]),
                    )
                  ],
                ),
              )),
          Positioned(
              top: 290,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: borderRadius2,
                    color: color1,
                    boxShadow: [boxshadow1]),
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _cartCount -= 1;
                          });
                        },
                        child: const Text(
                          '-',
                          style: TextStyle(color: Colors.white),
                        )),
                    Text(
                      '$_cartCount',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () {
                          setState(() {
                            _cartCount += 1;
                          });
                        },
                        child: const Text(
                          '+',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}

// class CartButton extends StatefulWidget {
//   const CartButton({Key? key}) : super(key: key);

//   @override
//   State<CartButton> createState() => _CartButtonState();
// }

// class _CartButtonState extends State<CartButton> {
//   int _cartCount = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: borderRadius2, color: color1, boxShadow: [boxshadow1]),
//       child: Row(
//         children: [
//           TextButton(
//               onPressed: () {
//                 setState(() {
//                   _cartCount -= 1;
//                 });
//               },
//               child: const Text(
//                 '-',
//                 style: TextStyle(color: Colors.white),
//               )),
//           Text(
//             '$_cartCount',
//             style: TextStyle(color: Colors.white),
//           ),
//           TextButton(
//               onPressed: () {
//                 setState(() {
//                   _cartCount += 1;
//                 });
//               },
//               child: const Text(
//                 '+',
//                 style: TextStyle(color: Colors.white),
//               ))
//         ],
//       ),
//     );
//   }
// }

class NavButton extends StatefulWidget {
  final id_produk, uid;
  const NavButton({Key? key, this.id_produk, this.uid}) : super(key: key);

  @override
  State<NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<NavButton> {
  bool _isFavorited = false;

  @override
  Widget build(BuildContext context) {
    final favorit = Provider.of<List<Favorit>>(context);
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius1,
              color: Colors.white,
            ),
            child: IconButton(
                color: color1,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios_rounded)),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: borderRadius1,
              color: Colors.white,
            ),
            child: IconButton(
              color: color1,
              onPressed: () {
                setState(() {
                  // _isFavorited = !_isFavorited;
                  if (favorit.isEmpty) {
                    FavoritDatabase(
                            uid: widget.uid, id_produk: widget.id_produk)
                        .addFavorit();
                  } else if (favorit.isNotEmpty) {
                    FavoritDatabase(
                            uid: widget.uid, id_produk: widget.id_produk)
                        .deleteFavorit();
                  }
                });
              },
              // icon: Icon(Icons.favorite_border_rounded)
              icon: (favorit.isNotEmpty
                  ? const Icon(Icons.favorite_rounded)
                  : const Icon(Icons.favorite_border_rounded)),
            ),
          )
        ]);
  }
}
