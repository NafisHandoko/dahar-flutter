import 'package:dahar/global_styles.dart';
import 'package:flutter/material.dart';

class TransactionDone extends StatefulWidget {
  const TransactionDone({Key? key}) : super(key: key);

  @override
  State<TransactionDone> createState() => _TransactionDoneState();
}

class _TransactionDoneState extends State<TransactionDone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 100),
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
                        '23-02-2022',
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
                        '12.35.45',
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
                        'Rp.78.000,-',
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
                  onPressed: () {},
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
