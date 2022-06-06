import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dahar/models/user.dart';

class UserDatabase {
  final String? uid;
  UserDatabase({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  Future<void> updateUser(String nama, String email) async {
    return await userCollection.doc(uid).set({
      'nama': nama,
      'email': email,
    });
  }

  // List<User> _userListFromSnapshot(QuerySnapshot? snapshot) {
  //   return snapshot!.docs.map((doc) {
  //     return User(
  //         nama: doc.get('nama') ?? '',
  //         alamat: doc.get('alamat') ?? '',
  //         lat: doc.get('lat') ?? 0,
  //         long: doc.get('long') ?? 0,
  //         foto: doc.get('foto'));
  //   }).toList();
  // }

  // Stream<List<User>> get user {
  //   return userCollection.snapshots().map(_userListFromSnapshot);
  // }
}
