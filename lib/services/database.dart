// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dahar/models/produk.dart';

// class DatabaseService {
//   final String? uid;
//   DatabaseService({this.uid});

//   final CollectionReference produkCollection =
//       FirebaseFirestore.instance.collection('produk');

//   final CollectionReference tokoCollection =
//       FirebaseFirestore.instance.collection('toko');

//   // Future<void> updateUserData(String sugars, String name, int strength) async {
//   //   return await produkCollection
//   //       .doc(uid)
//   //       .set({'sugars': sugars, 'name': name, 'strength': strength});
//   // }

//   Future<void> updateToko(String nama, String alamat) async {
//     return await tokoCollection.doc(uid).set({
//       'nama': nama,
//       'alamat': alamat,
//     });
//   }

//   Future<void> addProduk(String nama, int harga, String deskripsi,
//       String gambar, double rating) async {
//     await produkCollection.add({
//       'nama': nama,
//       'harga': harga,
//       'deskripsi': deskripsi,
//       'gambar': gambar,
//       'rating': rating,
//       'id_toko': FirebaseFirestore.instance.doc('toko/' + uid!)
//     });
//   }

//   List<Produk> _produkListFromSnapshot(QuerySnapshot? snapshot) {
//     return snapshot!.docs.map((doc) {
//       return Produk(
//           id: doc.id,
//           nama: doc.get('nama') ?? '',
//           harga: doc.get('harga') ?? 0,
//           deskripsi: doc.get('deskripsi') ?? '',
//           gambar: doc.get('gambar') ?? '',
//           rating: doc.get('rating') ?? 0,
//           id_toko: doc.get('id_toko'));
//     }).toList();
//   }

//   Stream<List<Produk>> get produk {
//     return produkCollection.snapshots().map(_produkListFromSnapshot);
//   }

//   Stream<QuerySnapshot?> get toko {
//     return tokoCollection.snapshots();
//   }
// }
