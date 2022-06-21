import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dahar/models/dahar_user.dart';

class UserDatabase {
  final String? uid;
  UserDatabase({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  Future<void> updateUser(String nama, String email, String foto) async {
    return await userCollection
        .doc(uid)
        .set({'nama': nama, 'email': email, 'foto': foto});
  }

  List<DaharUser> _userListFromSnapshot(QuerySnapshot? snapshot) {
    return snapshot!.docs.map((doc) {
      return DaharUser(
          id: doc.id,
          nama: doc.get('nama') ?? '',
          email: doc.get('email') ?? '',
          foto: doc.get('foto'));
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
        foto: event.get('foto')));
  }
}
