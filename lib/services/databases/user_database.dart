import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dahar/models/dahar_user.dart';
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
}
