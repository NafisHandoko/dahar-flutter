import 'package:cloud_firestore/cloud_firestore.dart';

class Cart {
  final DocumentReference id_produk;
  final int kuantitas;
  final DocumentReference id_user;

  Cart(
      {required this.id_produk,
      required this.kuantitas,
      required this.id_user});
}
