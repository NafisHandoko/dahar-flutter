import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dahar/models/ordercart.dart';
import 'package:dahar/services/databases/rating_database.dart';

class OrderCartDatabase {
  final String? uid;
  OrderCartDatabase({this.uid});

  final CollectionReference orderCartCollection =
      FirebaseFirestore.instance.collection('order_cart');

  // Future<void> addOrderCart(
  //     DocumentReference id_order,
  //     String id_cart,
  //     DocumentReference id_produk,
  //     int kuantitas,
  //     int total,
  //     int status,
  //     DocumentReference id_seller) async {
  //   await orderCartCollection.add({
  //     // 'id_produk': FirebaseFirestore.instance.doc('produk/' + id_produk),
  //     // 'kuantitas': kuantitas,
  //     // 'id_user': FirebaseFirestore.instance.doc('user/' + uid!),
  //     'id_order': id_order,
  //     'id_cart': FirebaseFirestore.instance.doc('cart/' + id_cart),
  //     'id_produk': id_produk,
  //     'kuantitas': kuantitas,
  //     'total': total,
  //     'status': status,
  //     'id_seller': id_seller,
  //     'id_buyer': FirebaseFirestore.instance.doc('user/' + uid!),
  //   });
  // }

  Future<void> addOrderCart2(
      List orderCartList, DocumentReference id_order) async {
    var db = FirebaseFirestore.instance;
    var batch = db.batch();
    for (var doc in orderCartList) {
      var id_rating = await RatingDatabase(uid: uid)
          .addRating(0, doc['id_produk'], doc['id_seller']);
      var docRef = orderCartCollection.doc(); //automatically generate unique id
      batch.set(docRef, {
        'id_order': id_order,
        // 'id_cart': FirebaseFirestore.instance.doc('cart/' + doc['id_cart']),
        'id_produk': doc['id_produk'],
        'kuantitas': doc['kuantitas'],
        'total': doc['total'],
        'status': doc['status'],
        'id_rating': id_rating,
        'id_seller': doc['id_seller'],
        'id_buyer': FirebaseFirestore.instance.doc('user/' + uid!),
      });
    }
    return await batch.commit();
    // batch.commit().then((value) => value);
  }

  List<OrderCart> _orderCartListFromSnapshot(QuerySnapshot? snapshot) {
    return snapshot!.docs.map((doc) {
      return OrderCart(
          id: doc.id,
          id_order: doc.get('id_order'),
          id_produk: doc.get('id_produk'),
          kuantitas: doc.get('kuantitas') ?? 0,
          total: doc.get('total') ?? 0,
          status: doc.get('status') ?? 0,
          id_rating: doc.get('id_rating'),
          id_seller: doc.get('id_seller'),
          id_buyer: doc.get('id_buyer'));
    }).toList();
  }

  Stream<List<OrderCart>> get orderCartBuyer {
    return orderCartCollection
        .where('id_buyer',
            isEqualTo: FirebaseFirestore.instance.doc('user/' + uid!))
        .snapshots()
        .map(_orderCartListFromSnapshot);
  }

  Stream<List<OrderCart>> get orderCartSeller {
    return orderCartCollection
        .where('id_seller',
            isEqualTo: FirebaseFirestore.instance.doc('toko/' + uid!))
        .snapshots()
        .map(_orderCartListFromSnapshot);
  }

  Future<void> updateOrderCart(String id_orderCart, int status) async {
    return await orderCartCollection.doc(id_orderCart).update({
      'status': status,
    });
  }

  Future<void> deleteAllOrderCartBuyer() async {
    var orderCartData = orderCartCollection
        .where('id_buyer',
            isEqualTo: FirebaseFirestore.instance.doc('user/' + uid!))
        .where('status', isEqualTo: 3);
    orderCartData.get().then((docs) {
      docs.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }

  Future<void> deleteAllOrderCartSeller() async {
    var orderCartData = orderCartCollection
        .where('id_seller',
            isEqualTo: FirebaseFirestore.instance.doc('toko/' + uid!))
        .where('status', isEqualTo: 3);
    orderCartData.get().then((docs) {
      docs.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
  }
}
