import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dahar/models/dahar_user.dart';
import 'package:dahar/services/auth.dart';
import 'package:dahar/services/databases/produk_database.dart';
import 'package:dahar/services/databases/toko_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class UserDatabase {
  final String? uid;
  UserDatabase({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');
  final storageRef = FirebaseStorage.instance.ref();

  Future<void> updateUser(
      String nama, String email, String foto, String fotoRef) async {
    return await userCollection
        .doc(uid)
        .set({'nama': nama, 'email': email, 'foto': foto, 'fotoRef': fotoRef});
  }

  Future<void> updateUserNama(String nama) async {
    return await userCollection.doc(uid).update({
      'nama': nama,
    });
  }

  Future<void> updateUserFoto(String oldFotoRef, File foto) async {
    var imagesRef;
    if (oldFotoRef != 'images/default_user_photo.png') {
      imagesRef = storageRef.child(oldFotoRef);
      await imagesRef.delete();
    }

    var uuid = Uuid();
    String newFotoRef = 'images/${uuid.v4()}.jpg';
    imagesRef = storageRef.child(newFotoRef);
    await imagesRef.putFile(foto);
    String imageUrl = await imagesRef.getDownloadURL();
    return await userCollection
        .doc(uid)
        .update({'foto': imageUrl, 'fotoRef': newFotoRef});
  }

  List<DaharUser> _userListFromSnapshot(QuerySnapshot? snapshot) {
    return snapshot!.docs.map((doc) {
      return DaharUser(
          id: doc.id,
          nama: doc.get('nama') ?? '',
          email: doc.get('email') ?? '',
          foto: doc.get('foto'),
          fotoRef: doc.get('fotoRef'));
    }).toList();
  }

  // DaharUser _userListFromSnapshot2(DocumentSnapshot? doc) {
  //   return DaharUser(
  //       id: doc.id,
  //       nama: doc.get('nama') ?? '',
  //       email: doc.get('email') ?? '',
  //       foto: doc.get('foto'));
  // }

  Stream<List<DaharUser>> get user {
    return userCollection.snapshots().map(_userListFromSnapshot);
    // return userCollection.doc(uid).snapshots().map(_userListFromSnapshot2);
  }

  Stream<DaharUser> get user2 {
    // return userCollection.snapshots().map(_userListFromSnapshot);
    return userCollection.doc(uid).snapshots().map((event) => DaharUser(
        id: event.id,
        nama: event.get('nama'),
        email: event.get('email'),
        foto: event.get('foto'),
        fotoRef: event.get('fotoRef')));
  }

  Future<void> deleteUser() async {
    final CollectionReference tokoCollection =
        FirebaseFirestore.instance.collection('toko');
    final CollectionReference produkCollection =
        FirebaseFirestore.instance.collection('produk');

    var produkData = produkCollection.where('id_toko',
        isEqualTo: FirebaseFirestore.instance.doc('toko/' + uid!));
    produkData.get().then((docs) {
      docs.docs.forEach((doc) {
        // doc.reference.delete();
        ProdukDatabase().deleteProduk(doc.id, doc.get('gambarRef'));
      });
    });

    await TokoDatabase(uid: uid).deleteToko();

    userCollection.doc(uid).get().then((doc) {
      String fotoRef = doc.get('fotoRef');
      if (fotoRef != 'images/default_user_photo.png') {
        final imagesRef = storageRef.child(fotoRef);
        imagesRef.delete();
      }
      userCollection.doc(uid).delete().then((value) {
        AuthService().deleteAuthUser();
      });
      // final imagesRef = storageRef.child(fotoRef);
      // imagesRef.delete().then((value) {
      //   userCollection.doc(uid).delete().then((value) {
      //     AuthService().deleteAuthUser();
      //   });
      // });
    });
  }
}
