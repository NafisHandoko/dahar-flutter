import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dahar/models/favorit.dart';

class FavoritDatabase {
  final String? uid, id_produk;
  FavoritDatabase({this.uid, this.id_produk});

  final CollectionReference favoritCollection =
      FirebaseFirestore.instance.collection('favorit');

  Future<void> addFavorit() async {
    await favoritCollection.add({
      'id_produk': FirebaseFirestore.instance.doc('produk/' + id_produk!),
      'id_user': FirebaseFirestore.instance.doc('user/' + uid!),
    });
  }

  List<Favorit> _favoritListFromSnapshot(QuerySnapshot? snapshot) {
    return snapshot!.docs.map((doc) {
      return Favorit(
          id: doc.id,
          id_produk: doc.get('id_produk'),
          id_user: doc.get('id_user'));
    }).toList();
  }

  Stream<List<Favorit>> get isFavorit {
    return favoritCollection
        .where('id_user',
            isEqualTo: FirebaseFirestore.instance.doc('user/' + uid!))
        .where('id_produk',
            isEqualTo: FirebaseFirestore.instance.doc('produk/' + id_produk!))
        .snapshots()
        .map(_favoritListFromSnapshot);
  }

  Stream<List<Favorit>> get favorit {
    return favoritCollection
        .where('id_user',
            isEqualTo: FirebaseFirestore.instance.doc('user/' + uid!))
        .snapshots()
        .map(_favoritListFromSnapshot);
  }

  Future<void> deleteFavorit() async {
    var favoritData = favoritCollection
        .where('id_user',
            isEqualTo: FirebaseFirestore.instance.doc('user/' + uid!))
        .where('id_produk',
            isEqualTo: FirebaseFirestore.instance.doc('produk/' + id_produk!));
    favoritData.get().then((docs) {
      docs.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }
}
