import 'package:cloud_firestore/cloud_firestore.dart';

class OrderCart {
  final String id;
  final DocumentReference id_order;
  final DocumentReference id_produk;
  final int kuantitas;
  final int total;
  final int status;
  final DocumentReference id_rating;
  final DocumentReference id_seller;
  final DocumentReference id_buyer;

  OrderCart(
      {required this.id,
      required this.id_order,
      required this.id_produk,
      required this.kuantitas,
      required this.total,
      required this.status,
      required this.id_rating,
      required this.id_seller,
      required this.id_buyer});
}
