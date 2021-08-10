import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flightclub/models/product_data.dart';
import 'package:flutter/material.dart';

import '../models/firebase_query.dart';

class ProductBloc extends ChangeNotifier {
  final _productSnapshot = <DocumentSnapshot>[];
  String _errorMessage = '';
  int documentLimit = 10;
  bool _hasNext = true;
  bool _isFetchingProducts = false;

  bool get hasNext {
    return _hasNext;
  }
  String get errorMessage {
    return _errorMessage;
  }

  List<ProductData> get productData => _productSnapshot.map((snap) {
        final Map<String, dynamic> product =
            snap.data() as Map<String, dynamic>;

        return ProductData(
          category: product['category'],
          description: product['description'],
          exclusive: product['exclusive'],
          featured: product['featured'],
          name: product['name'],
          price: product['price'],
          sku: product['sku'],
          image: product['image'],
        );
      }).toList();

  Future fetchNextProducts() async {
    if (_isFetchingProducts) return;

    _isFetchingProducts = true;

    try {
      // Reads firestore collection products
      final snap = await FirebaseQuery.getProducts(
        documentLimit,
        startAfter: _productSnapshot.isNotEmpty ? _productSnapshot.last : null,
      );
      _productSnapshot.addAll(snap.docs);
      if (snap.docs.length < documentLimit) _hasNext = false;
      notifyListeners();
    } catch (error) {
      _errorMessage = error.toString();
      notifyListeners();
    }

    _isFetchingProducts = false;
  }
}
