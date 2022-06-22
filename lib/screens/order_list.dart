import 'package:dahar/models/auth_user.dart';
import 'package:dahar/models/ordercart.dart';
import 'package:dahar/services/databases/ordercart_database.dart';
import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';
import 'package:dahar/components/navbar.dart';
import 'package:dahar/components/back_appbar.dart';
import 'package:provider/provider.dart';

class OrderList extends StatelessWidget {
  const OrderList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthUser user = Provider.of<AuthUser>(context);
    return StreamProvider<List<OrderCart>>.value(
      initialData: [],
      value: OrderCartDatabase(uid: user.uid).orderCartSeller,
      child: Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: BackAppBar(
                title: 'Daftar Pesanan',
              )),
          body: OrderListProvider(),
          bottomNavigationBar: const NavBar()),
    );
  }
}

class OrderListProvider extends StatelessWidget {
  const OrderListProvider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderCart = Provider.of<List<OrderCart>>(context);
    return OrderListBuilder(
      orderCart: orderCart,
    );
  }
}

class OrderListBuilder extends StatelessWidget {
  final orderCart;
  const OrderListBuilder({Key? key, this.orderCart}) : super(key: key);

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
                return OrderListItem(
                    key: ValueKey(orderCart[index].id),
                    orderCart: orderCart[index]);
              }),
          // child: ListView(children: const [
          //   OrderListItem(),
          //   OrderListItem(),
          //   OrderListItem(),
          //   OrderListItem(),
          //   OrderListItem()
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
                onPressed: () {},
              ),
            ))
      ],
    );
    // return Container(
    //   padding: const EdgeInsets.symmetric(horizontal: 25),
    //   color: Colors.white,
    //   child: ListView(children: const [
    //     OrderListItem(
    //       isConfirmed: false,
    //     ),
    //     OrderListItem(
    //       isConfirmed: false,
    //     ),
    //     OrderListItem(
    //       isConfirmed: false,
    //     )
    //   ]),
    // );
  }
}

class OrderListItem extends StatefulWidget {
  final orderCart;
  const OrderListItem({Key? key, this.orderCart}) : super(key: key);

  @override
  State<OrderListItem> createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  bool isConfirmed = false;
  int ratingLevel = -1;
  String? foodName;
  int? foodPrice;
  String? foodSeller;
  String? foodImage;

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
  }

  Widget _buildStar(int starCount) {
    return InkWell(
      child: Icon(
        Icons.star,
        size: 20.0,
        color: ratingLevel >= starCount ? Colors.orange : Colors.grey,
      ),
      onTap: () {
        setState(() {
          ratingLevel = starCount;
        });
      },
    );
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
                        (ratingLevel >= 0)
                            ? Row(
                                children: [
                                  _buildStar(1),
                                  _buildStar(2),
                                  _buildStar(3),
                                  _buildStar(4),
                                  _buildStar(5),
                                ],
                              )
                            : (widget.orderCart.status < 2)
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
                                        (widget.orderCart.status == 0)
                                            ? 'Proses'
                                            : (widget.orderCart.status == 1)
                                                ? 'Kirim'
                                                : '',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        OrderCartDatabase().updateOrderCart(
                                            widget.orderCart.id,
                                            widget.orderCart.status + 1);
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
  const RatingDialog({Key? key}) : super(key: key);

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
            Text('Kari Spesial',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            Text('Warung Bu Supiah',
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
