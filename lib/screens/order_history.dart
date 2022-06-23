import 'package:dahar/models/auth_user.dart';
import 'package:dahar/models/ordercart.dart';
import 'package:dahar/services/databases/ordercart_database.dart';
import 'package:dahar/services/databases/rating_database.dart';
import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';
import 'package:dahar/components/navbar.dart';
import 'package:dahar/components/back_appbar.dart';
import 'package:provider/provider.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthUser user = Provider.of<AuthUser>(context);
    return StreamProvider<List<OrderCart>>.value(
      initialData: [],
      value: OrderCartDatabase(uid: user.uid).orderCartBuyer,
      child: Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: BackAppBar(
                title: 'Riwayat Pemesanan',
              )),
          body: OrderHistoryProvider(uid: user.uid),
          bottomNavigationBar: const NavBar()),
    );
  }
}

class OrderHistoryProvider extends StatelessWidget {
  final uid;
  const OrderHistoryProvider({Key? key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderCart = Provider.of<List<OrderCart>>(context);
    return OrderHistoryBuilder(
      orderCart: orderCart,
      uid: uid,
    );
  }
}

class OrderHistoryBuilder extends StatelessWidget {
  final orderCart, uid;
  const OrderHistoryBuilder({Key? key, this.orderCart, this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          color: Colors.white,
          child: ListView.builder(
              itemCount: orderCart.length,
              itemBuilder: (context, index) {
                return HistoryItem(
                    key: ValueKey(orderCart[index].id),
                    orderCart: orderCart[index]);
              }),
          // child: ListView(children: const [
          //   HistoryItem(),
          //   HistoryItem(),
          //   HistoryItem(),
          //   HistoryItem(),
          //   HistoryItem()
          // ]),
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: const EdgeInsets.only(bottom: 15, left: 25, right: 25),
              // width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: borderRadius2,
                  color: color1,
                  boxShadow: [boxshadow1]),
              child: TextButton(
                child: const Text(
                  'Clear Successfull Order',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  OrderCartDatabase(uid: uid).deleteAllOrderCartBuyer();
                },
              ),
            ))
      ],
    );
    // return Container(
    //   padding: const EdgeInsets.symmetric(horizontal: 25),
    //   color: Colors.white,
    //   child: ListView(children: const [
    //     HistoryItem(
    //       isConfirmed: false,
    //     ),
    //     HistoryItem(
    //       isConfirmed: false,
    //     ),
    //     HistoryItem(
    //       isConfirmed: false,
    //     )
    //   ]),
    // );
  }
}

class HistoryItem extends StatefulWidget {
  final orderCart;
  const HistoryItem({Key? key, this.orderCart}) : super(key: key);

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  bool isConfirmed = false;
  // int ratingLevel = -1;
  String? foodName;
  int? foodPrice;
  String? foodSeller;
  String? foodImage;
  int rating = 0;

  @override
  void initState() {
    super.initState();
    // isConfirmed = widget.isConfirmed;
    // ratingLevel = widget.ratingLevel;
    widget.orderCart.id_produk.get().then((value) {
      setState(() {
        foodName = value.get('nama');
        foodImage = value.get('gambar');
      });
    });
    widget.orderCart.id_seller.get().then((value) {
      setState(() {
        foodSeller = value.get('nama');
      });
    });
    // widget.orderCart.id_rating.get().then((value) {
    //   setState(() {
    //     rating = value.get('rating');
    //   });
    // });
  }

  Widget _buildStar(int starCount) {
    return InkWell(
      child: Icon(
        Icons.star,
        size: 20.0,
        color: rating >= starCount ? Colors.orange : Colors.grey,
      ),
      onTap: () {
        setState(() {
          // rating = starCount;
          RatingDatabase().updateRating(widget.orderCart.id_rating, starCount);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    widget.orderCart.id_rating.get().then((value) {
      setState(() {
        rating = value.get('rating');
      });
    });
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
                      image: NetworkImage('$foodImage'), fit: BoxFit.cover)),
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
                  Text(
                    'Rp ${widget.orderCart.total / widget.orderCart.kuantitas} x ${widget.orderCart.kuantitas}',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: colorGrey),
                  ),
                  Text(
                    'Total Pesanan : Rp ${widget.orderCart.total}',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: (widget.orderCart.status == 3)
                                  ? colorGreenStatusCont
                                  : colorYellowStatusCont,
                              borderRadius: borderRadius2),
                          child: Text(
                            // (isConfirmed ? 'Selesai' : 'Belum dikonfirmasi'),
                            (widget.orderCart.status == 0)
                                ? 'Belum diproses'
                                : (widget.orderCart.status == 1)
                                    ? 'Diproses'
                                    : (widget.orderCart.status == 2)
                                        ? 'Dikirim'
                                        : (widget.orderCart.status == 3)
                                            ? 'Selesai'
                                            : '',
                            style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                                color: (widget.orderCart.status == 3)
                                    ? colorGreenStatusText
                                    : colorYellowStatusText),
                          ),
                        ),
                        (rating > 0)
                            ? Row(
                                children: [
                                  _buildStar(1),
                                  _buildStar(2),
                                  _buildStar(3),
                                  _buildStar(4),
                                  _buildStar(5),
                                ],
                              )
                            : (widget.orderCart.status >= 2)
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: borderRadius2,
                                        color: color1,
                                        boxShadow: [boxshadow1]),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        // maximumSize: Size(10, 10),
                                        // alignment: Alignment.centerLeft
                                      ),
                                      child: Text(
                                        (widget.orderCart.status == 2)
                                            ? 'Diterima'
                                            : 'Beri Rating',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        if (widget.orderCart.status >= 3) {
                                          int stars = await showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (_) => RatingDialog(
                                                    foodName: foodName,
                                                    foodSeller: foodSeller,
                                                  ));
                                          print('Selected rate stars: $stars');
                                          setState(() {
                                            // rating = stars;
                                            RatingDatabase().updateRating(
                                                widget.orderCart.id_rating,
                                                stars);
                                          });
                                        } else {
                                          setState(() {
                                            // isConfirmed = true;
                                            OrderCartDatabase().updateOrderCart(
                                                widget.orderCart.id,
                                                widget.orderCart.status + 1);
                                          });
                                        }
                                      },
                                    ),
                                  )
                                : Container()
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

class RatingDialog extends StatefulWidget {
  final foodName, foodSeller;
  const RatingDialog({Key? key, this.foodName, this.foodSeller})
      : super(key: key);

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _stars = 0;

  Widget _buildStar(int starCount) {
    return InkWell(
      child: Icon(
        Icons.star,
        // size: 30.0,
        color: _stars >= starCount ? Colors.orange : Colors.grey,
      ),
      onTap: () {
        setState(() {
          _stars = starCount;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: borderRadius1),
      title: Center(
        child: Column(
          children: [
            Text('${widget.foodName}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            Text('${widget.foodSeller}',
                style: TextStyle(
                    fontSize: 12, fontWeight: FontWeight.w400, color: color1))
          ],
        ),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildStar(1),
          _buildStar(2),
          _buildStar(3),
          _buildStar(4),
          _buildStar(5),
        ],
      ),
      actions: <Widget>[
        // TextButton(
        //   child: Text('CANCEL'),
        //   onPressed: Navigator.of(context).pop,
        // ),
        Center(
          child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
                borderRadius: borderRadius2,
                color: color1,
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
                Navigator.of(context).pop(_stars);
              },
            ),
          ),
        )
      ],
    );
  }
}
