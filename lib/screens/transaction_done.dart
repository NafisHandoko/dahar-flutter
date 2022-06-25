import 'package:dahar/global_styles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionDone extends StatefulWidget {
  final totalPrice;
  const TransactionDone({Key? key, this.totalPrice}) : super(key: key);

  @override
  State<TransactionDone> createState() => _TransactionDoneState();
}

class _TransactionDoneState extends State<TransactionDone> {
  String date = '';
  String time = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    date = DateFormat("yyyy-MM-dd").format(DateTime.now());
    time = DateFormat("HH:mm:ss").format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 25, top: 100, right: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 90,
                    color: Colors.green,
                  ),
                  Text(
                    'Order Success!',
                    style: TextStyle(
                      fontSize: 30,
                      height: 2,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 50)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Date',
                        style: TextStyle(fontSize: 18, height: 3),
                      ),
                      Text(
                        '$date',
                        style: TextStyle(fontSize: 18, height: 3),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Time',
                        style: TextStyle(fontSize: 18, height: 3),
                      ),
                      Text(
                        '$time',
                        style: TextStyle(fontSize: 18, height: 3),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Expense',
                        style: TextStyle(fontSize: 18, height: 3),
                      ),
                      Text(
                        'Rp ${widget.totalPrice}',
                        style: TextStyle(fontSize: 18, height: 3),
                      )
                    ],
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: borderRadius1,
                    color: color1,
                    boxShadow: [boxshadow1]),
                child: TextButton(
                  onPressed: () {
                    Navigator.popUntil(
                      context,
                      ModalRoute.withName('/'),
                    );
                  },
                  child: Text(
                    'Back To Home',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
