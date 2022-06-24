import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dahar/models/produk.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class ProdukDatabase {
  final String? uid;
  ProdukDatabase({this.uid});

  final CollectionReference produkCollection =
      FirebaseFirestore.instance.collection('produk');
  final storageRef = FirebaseStorage.instance.ref();

  Future<void> addProduk(String nama, int harga, String deskripsi, File gambar,
      double rating) async {
    var uuid = Uuid();
    String gambarRef = 'images/${uuid.v4()}.jpg';
    final imagesRef = storageRef.child(gambarRef);
    await imagesRef.putFile(gambar);
    String imageUrl = await imagesRef.getDownloadURL();
    await produkCollection.add({
      'nama': nama,
      'harga': harga,
      'deskripsi': deskripsi,
      'gambar': imageUrl,
      'gambarRef': gambarRef,
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
          gambarRef: doc.get('gambarRef') ?? '',
          rating: doc.get('rating') ?? 0,
          id_toko: doc.get('id_toko'));
    }).toList();
  }

  Stream<List<Produk>> get produk {
    return produkCollection
        .where('id_toko',
            isNotEqualTo: FirebaseFirestore.instance.doc('toko/' + uid!))
        .snapshots()
        .map(_produkListFromSnapshot);
  }

  Stream<List<Produk>> get produkOnToko {
    return produkCollection
        .where('id_toko',
            isEqualTo: FirebaseFirestore.instance.doc('toko/' + uid!))
        .snapshots()
        .map(_produkListFromSnapshot);
  }

  Future<void> deleteProduk(String id_produk, String gambarRef) async {
    final CollectionReference cartCollection =
        FirebaseFirestore.instance.collection('cart');
    final CollectionReference favoritCollection =
        FirebaseFirestore.instance.collection('favorit');
    final CollectionReference orderCartCollection =
        FirebaseFirestore.instance.collection('order_cart');
    final CollectionReference ratingCollection =
        FirebaseFirestore.instance.collection('rating');

    var cartData = cartCollection.where('id_produk',
        isEqualTo: FirebaseFirestore.instance.doc('produk/' + id_produk));
    cartData.get().then((docs) {
      docs.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
    var favoritData = favoritCollection.where('id_produk',
        isEqualTo: FirebaseFirestore.instance.doc('produk/' + id_produk));
    favoritData.get().then((docs) {
      docs.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
    var orderCartData = orderCartCollection.where('id_produk',
        isEqualTo: FirebaseFirestore.instance.doc('produk/' + id_produk));
    orderCartData.get().then((docs) {
      docs.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
    var ratingData = ratingCollection.where('id_produk',
        isEqualTo: FirebaseFirestore.instance.doc('produk/' + id_produk));
    ratingData.get().then((docs) {
      docs.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
    final imagesRef = storageRef.child(gambarRef);
    await imagesRef.delete();
    await produkCollection.doc(id_produk).delete();
  }

  Future<void> updateProduk(String id_produk, int harga, String nama,
      String deskripsi, String oldGambarRef, File gambar) async {
    var imagesRef = storageRef.child(oldGambarRef);
    await imagesRef.delete();

    var uuid = Uuid();
    String newGambarRef = 'images/${uuid.v4()}.jpg';
    imagesRef = storageRef.child(newGambarRef);
    await imagesRef.putFile(gambar);
    String imageUrl = await imagesRef.getDownloadURL();
    return await produkCollection.doc(id_produk).update({
      'nama': nama,
      'harga': harga,
      'deskripsi': deskripsi,
      'gambar': imageUrl,
      'gambarRef': newGambarRef,
    });
  }
}
