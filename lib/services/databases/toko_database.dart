import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dahar/models/toko.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class TokoDatabase {
  final String? uid;
  TokoDatabase({this.uid});

  final CollectionReference tokoCollection =
      FirebaseFirestore.instance.collection('toko');
  final storageRef = FirebaseStorage.instance.ref();

  Future<void> updateToko(String nama, String alamat, double lat, double long,
      String foto, String fotoRef) async {
    return await tokoCollection.doc(uid).set({
      'nama': nama,
      'alamat': alamat,
      'lat': lat,
      'long': long,
      'foto': foto,
      'fotoRef': fotoRef
    });
  }

  Future<void> updateTokoNama(String nama) async {
    return await tokoCollection.doc(uid).update({
      'nama': nama,
    });
  }

  Future<void> updateTokoAlamat(String alamat) async {
    return await tokoCollection.doc(uid).update({
      'alamat': alamat,
    });
  }

  Future<void> updateTokoFoto(String oldFotoRef, File foto) async {
    var imagesRef;
    if (oldFotoRef != 'images/default_toko_photo.png') {
      imagesRef = storageRef.child(oldFotoRef);
      await imagesRef.delete();
    }

    var uuid = Uuid();
    String newFotoRef = 'images/${uuid.v4()}.jpg';
    imagesRef = storageRef.child(newFotoRef);
    await imagesRef.putFile(foto);
    String imageUrl = await imagesRef.getDownloadURL();
    return await tokoCollection
        .doc(uid)
        .update({'foto': imageUrl, 'fotoRef': newFotoRef});
  }

  List<Toko> _tokoListFromSnapshot(QuerySnapshot? snapshot) {
    return snapshot!.docs.map((doc) {
      return Toko(
          id: doc.id,
          nama: doc.get('nama') ?? '',
          alamat: doc.get('alamat') ?? '',
          lat: doc.get('lat') ?? 0,
          long: doc.get('long') ?? 0,
          foto: doc.get('foto'),
          fotoRef: doc.get('fotoRef'));
    }).toList();
  }

  Stream<List<Toko>> get toko {
    return tokoCollection.snapshots().map(_tokoListFromSnapshot);
  }

  Stream<Toko> get myToko {
    // return userCollection.snapshots().map(_userListFromSnapshot);
    return tokoCollection.doc(uid).snapshots().map((doc) => Toko(
        id: doc.id,
        nama: doc.get('nama') ?? '',
        alamat: doc.get('alamat') ?? '',
        lat: doc.get('lat') ?? 0,
        long: doc.get('long') ?? 0,
        foto: doc.get('foto'),
        fotoRef: doc.get('fotoRef')));
  }
}
