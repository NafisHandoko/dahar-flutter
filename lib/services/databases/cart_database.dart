import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dahar/models/cart.dart';

class CartDatabase {
  final String? uid;
  CartDatabase({this.uid});

  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection('cart');

  Future<void> addCart(int kuantitas, String id_produk) async {
    await cartCollection.add({
      'id_produk': FirebaseFirestore.instance.doc('produk/' + id_produk),
      'kuantitas': kuantitas,
      'id_user': FirebaseFirestore.instance.doc('user/' + uid!),
    });
  }

  Future<void> updateCart(String id_cart, int kuantitas) async {
    return await cartCollection.doc(id_cart).update({
      'kuantitas': kuantitas,
    });
  }

  Future<void> deleteCart(String id_cart) async {
    await cartCollection.doc(id_cart).delete();
  }

  Future<void> deleteAllCart() async {
    var cartData = cartCollection.where('id_user',
        isEqualTo: FirebaseFirestore.instance.doc('user/' + uid!));
    cartData.get().then((docs) {
      docs.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }

  List<Cart> _cartListFromSnapshot(QuerySnapshot? snapshot) {
    return snapshot!.docs.map((doc) {
      return Cart(
          id: doc.id,
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
