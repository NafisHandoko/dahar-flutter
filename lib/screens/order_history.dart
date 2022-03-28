import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';
import 'package:dahar/components/navbar.dart';
import 'package:dahar/components/back_appbar.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: BackAppBar(
              title: 'Riwayat Pemesanan',
            )),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          color: Colors.white,
          child: ListView(children: const [
            HistoryItem(
              isConfirmed: false,
            ),
            HistoryItem(
              isConfirmed: false,
            ),
            HistoryItem(
              isConfirmed: false,
            )
          ]),
        ),
        bottomNavigationBar: const NavBar());
  }
}

class HistoryItem extends StatefulWidget {
  final String foodImage, foodName, foodSeller;
  final int foodPrice, foodAmount, ratingLevel;
  final bool isConfirmed;
  const HistoryItem(
      {Key? key,
      this.foodImage =
          'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
      this.foodName = 'Kari Spesial',
      this.foodSeller = 'Warung Bu Supiah',
      this.foodPrice = 20000,
      this.foodAmount = 3,
      this.ratingLevel = -1,
      required this.isConfirmed})
      : super(key: key);

  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  bool isConfirmed = false;
  int ratingLevel = -1;

  @override
  void initState() {
    super.initState();
    isConfirmed = widget.isConfirmed;
    ratingLevel = widget.ratingLevel;
  }

  Widget _buildStar(int starCount) {
    return InkWell(
      child: Icon(
        Icons.star,
        // size: 30.0,
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
                      image: NetworkImage(widget.foodImage),
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
                    widget.foodName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    widget.foodSeller,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: color1),
                  ),
                  Text(
                    'Rp ${widget.foodPrice} x ${widget.foodAmount}',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: colorGrey),
                  ),
                  Text(
                    'Total Pesanan : Rp ${widget.foodPrice * widget.foodAmount}',
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
                              color: isConfirmed
                                  ? colorGreenStatusCont
                                  : colorYellowStatusCont,
                              borderRadius: borderRadius1),
                          child: Text(
                            (isConfirmed ? 'Selesai' : 'Belum dikonfirmasi'),
                            style: TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                                color: isConfirmed
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
                            : Container(
                                decoration: BoxDecoration(
                                    borderRadius: borderRadius1,
                                    color: color1,
                                    boxShadow: [boxshadow1]),
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    // maximumSize: Size(10, 10),
                                    // alignment: Alignment.centerLeft
                                  ),
                                  child: Text(
                                    (isConfirmed
                                        ? 'Beri Rating'
                                        : 'Konfirmasi'),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () async {
                                    if (isConfirmed) {
                                      int stars = await showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (_) => RatingDialog());
                                      print('Selected rate stars: $stars');
                                      setState(() {
                                        ratingLevel = stars;
                                      });
                                    } else {
                                      setState(() {
                                        isConfirmed = true;
                                      });
                                    }
                                  },
                                ),
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
                borderRadius: borderRadius1,
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
