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
                fontSize: 50,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
