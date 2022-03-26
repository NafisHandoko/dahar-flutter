import 'package:flutter/material.dart';
import 'package:dahar/global_styles.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(100), child: HistoryAppBar()),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        color: Colors.white,
        child: ListView(children: [_historyItem(), _historyItem()]),
      ),
    );
  }
}

class HistoryAppBar extends StatelessWidget {
  const HistoryAppBar({Key? key}) : super(key: key);

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
                Icons.arrow_back_ios_rounded,
              ),
              color: color1,
              onPressed: () {},
            ),
            const Text(
              "Riwayat Pemesanan",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
            IconButton(
              // constraints: const BoxConstraints(),
              alignment: Alignment.center,
              icon: const Icon(
                Icons.search_rounded,
              ),
              color: Colors.white,
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}

Container _historyItem() {
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
                image: const DecorationImage(
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1572656631137-7935297eff55?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80'),
                    fit: BoxFit.cover)),
          ),
          Expanded(
            // color: Colors.amberAccent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  'Kari Spesial',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
                Text(
                  'Warung Bu Supiah',
                  style: TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w400, color: color1),
                ),
                Text(
                  'Rp 20.000 x 3',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: colorGrey),
                ),
                const Text(
                  'Total Pesanan : Rp 60.000',
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
                            color: colorYellowStatusCont,
                            borderRadius: borderRadius1),
                        child: Text(
                          'Belum dikonfirmasi',
                          style: TextStyle(
                              fontSize: 8,
                              fontWeight: FontWeight.w500,
                              color: colorYellowStatusText),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: borderRadius1,
                            color: color1,
                            boxShadow: [boxshadow1]),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            // maximumSize: Size(10, 10),
                            // alignment: Alignment.centerLeft
                          ),
                          child: const Text(
                            'Konfirmasi',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {},
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
