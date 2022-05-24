import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference produkCollection =
      FirebaseFirestore.instance.collection('produk');

  final CollectionReference tokoCollection =
      FirebaseFirestore.instance.collection('toko');

  // Future<void> updateUserData(String sugars, String name, int strength) async {
  //   return await produkCollection
  //       .doc(uid)
  //       .set({'sugars': sugars, 'name': name, 'strength': strength});
  // }

  Future<void> updateToko(String nama, String alamat) async {
    return await tokoCollection.doc(uid).set({
      'nama': nama,
      'alamat': alamat,
    });
  }

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

  Stream<QuerySnapshot?> get produk {
    return produkCollection.snapshots();
  }
}
