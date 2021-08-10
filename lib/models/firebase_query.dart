import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_pagination'

class FirebaseQuery {
  static final productCollection =
      FirebaseFirestore.instance.collection('products');

  static Future<QuerySnapshot> getProducts(int limit,
      {DocumentSnapshot? startAfter}) async {
    final productLimit = productCollection.limit(limit);
    if (startAfter == null) {
        return productLimit.get();
    }

    return productLimit.startAfterDocument(startAfter).get();
  }

}
