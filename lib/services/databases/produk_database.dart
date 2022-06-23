import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dahar/models/produk.dart';

class ProdukDatabase {
  final String? uid;
  ProdukDatabase({this.uid});

  final CollectionReference produkCollection =
      FirebaseFirestore.instance.collection('produk');

  Future<void> addProduk(String nama, int harga, String deskripsi,
      String gambar, double rating) async {
    await produkCollection.add({
      'nama': nama,
      'harga': harga,
      'deskripsi': deskripsi,
      'gambar': gambar,
      'rating': rating,
      'id_toko': FirebaseFirestore.instance.doc('toko/' + uid!)
    });
  }

  List<Produk> _produkListFromSnapshot(QuerySnapshot? snapshot) {
    return snapshot!.docs.map((doc) {
      // log('${doc.get('id_toko').id}');
      // String namaToko;
      // var tokoRef =
      //     FirebaseFirestore.instance.doc('toko/' + doc.get('id_toko').id).get();
      // tokoRef.then((val) {
      //   String namaToko = val.get('nama');
      // });
      return Produk(
          id: doc.id,
          nama: doc.get('nama') ?? '',
          harga: doc.get('harga') ?? 0,
          deskripsi: doc.get('deskripsi') ?? '',
          gambar: doc.get('gambar') ?? '',
          rating: doc.get('rating') ?? 0,
          id_toko: doc.get('id_toko'));
    }).toList();
  }

  Stream<List<Produk>> get produk {
    return produkCollection.snapshots().map(_produkListFromSnapshot);
  }

  Stream<List<Produk>> get myProduks {
    return produkCollection
        .where('id_toko',
            isEqualTo: FirebaseFirestore.instance.doc('toko/' + uid!))
        .snapshots()
        .map(_produkListFromSnapshot);
  }
}
