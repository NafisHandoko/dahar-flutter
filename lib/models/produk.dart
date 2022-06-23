import 'package:cloud_firestore/cloud_firestore.dart';

class Produk {
  final String id;
  final String nama;
  final int harga;
  final String deskripsi;
  final String gambar;
  final String gambarRef;
  final double rating;
  final DocumentReference id_toko;

  Produk(
      {required this.id,
      required this.nama,
      required this.harga,
      required this.deskripsi,
      required this.gambar,
      required this.gambarRef,
      required this.rating,
      required this.id_toko});
}
