import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dahar/models/toko.dart';

class TokoDatabase {
  final String? uid;
  TokoDatabase({this.uid});

  final CollectionReference tokoCollection =
      FirebaseFirestore.instance.collection('toko');

  Future<void> updateToko(
      String nama, String alamat, double lat, double long) async {
    return await tokoCollection
        .doc(uid)
        .set({'nama': nama, 'alamat': alamat, 'lat': lat, 'long': long});
  }

  List<Toko> _tokoListFromSnapshot(QuerySnapshot? snapshot) {
    return snapshot!.docs.map((doc) {
      return Toko(
          nama: doc.get('nama') ?? '',
          alamat: doc.get('alamat') ?? '',
          lat: doc.get('lat') ?? 0,
          long: doc.get('long') ?? 0);
    }).toList();
  }

  Stream<List<Toko>> get toko {
    return tokoCollection.snapshots().map(_tokoListFromSnapshot);
  }
}
