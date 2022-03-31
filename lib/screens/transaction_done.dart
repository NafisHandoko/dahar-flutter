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
          child: Column(
            children: [
              Icon(
                Icons.check_circle,
                size: 100,
                color: Colors.green,
              ),
              Text(
                'Order Success!',
                style: TextStyle(
                  fontSize: 35,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Date 23-02-2022',
                    style: TextStyle(fontSize: 18, wordSpacing: 140),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Time 12.35.45',
                    style: TextStyle(fontSize: 18, wordSpacing: 155),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Expense Rp.78.000,-',
                    style: TextStyle(fontSize: 18, wordSpacing: 110),
                  ),
                ],
              ),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Color.fromRGBO(238, 117, 73, 1)),
                onPressed: () {},
                child: Text(
                  'Back To Home',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
