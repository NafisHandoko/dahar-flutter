import 'package:cloud_firestore/cloud_firestore.dart';

class Favorit {
  final String id;
  final DocumentReference id_produk;
  final DocumentReference id_user;

  Favorit({required this.id, required this.id_produk, required this.id_user});
}
