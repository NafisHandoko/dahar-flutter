import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dahar/models/toko.dart';

class TokoDatabase {
  final String? uid;
  TokoDatabase({this.uid});

  final CollectionReference tokoCollection =
      FirebaseFirestore.instance.collection('toko');

  Future<void> updateToko(
      String nama, String alamat, double lat, double long, String foto) async {
    return await tokoCollection.doc(uid).set({
      'nama': nama,
      'alamat': alamat,
      'lat': lat,
      'long': long,
      'foto': foto
    });
  }

  List<Toko> _tokoListFromSnapshot(QuerySnapshot? snapshot) {
    return snapshot!.docs.map((doc) {
      return Toko(
          id: doc.id,
          nama: doc.get('nama') ?? '',
          alamat: doc.get('alamat') ?? '',
          lat: doc.get('lat') ?? 0,
          long: doc.get('long') ?? 0,
          foto: doc.get('foto'));
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
        foto: doc.get('foto')));
  }
}
