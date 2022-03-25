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
        child: ListView(children: []),
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
