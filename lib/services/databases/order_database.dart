import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDatabase {
  final String? uid;
  OrderDatabase({this.uid});

  final CollectionReference orderCollection =
      FirebaseFirestore.instance.collection('order');

  Future<DocumentReference<Object?>> addOrder(
      String alamat, String payment, int total) async {
    return await orderCollection.add({
      'total': total,
      'alamat': alamat,
      'payment': payment,
      'id_user': FirebaseFirestore.instance.doc('user/' + uid!),
    });
  }
}
