import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dahar/models/cart.dart';

class CartDatabase {
  final String? uid;
  CartDatabase({this.uid});

  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('cart');

  Future<void> updateCart(int kuantitas) async {
    return await cartCollection.doc(uid).set({
      'id_produk': FirebaseFirestore.instance.doc('produk/' + uid!),
      'kuantitas': kuantitas,
      'id_user': FirebaseFirestore.instance.doc('user/' + uid!),
    });
  }

  List<Cart> _cartListFromSnapshot(QuerySnapshot? snapshot) {
    return snapshot!.docs.map((doc) {
      return Cart(
          id_produk: doc.get('id_produk'),
          kuantitas: doc.get('kuantitas') ?? 0,
          id_user: doc.get('id_user'));
    }).toList();
  }

  Stream<List<Cart>> get cart {
    return cartCollection
        .where('id_user',
            isEqualTo: FirebaseFirestore.instance.doc('user/' + uid!))
        .snapshots()
        .map(_cartListFromSnapshot);
  }
}
