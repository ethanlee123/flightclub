import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flightclub/models/product_data.dart';
import 'package:flutter/material.dart';

import '../models/firebase_query.dart';

class ProductBloc extends ChangeNotifier {
  // Contains all products
  final _productSnapshot = <DocumentSnapshot>[];
  // Contains only featured products
  final _productFeaturedSnapshot = <DocumentSnapshot>[];
  // Contains only exclusive products
  final _productExclusiveSnapshot = <DocumentSnapshot>[];

  String _errorMessage = '';
  int documentLimit = 5;
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
  List<ProductData> get featuredProductData =>
      _productFeaturedSnapshot.map((snap) {
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
  List<ProductData> get exclusiveProductData =>
      _productExclusiveSnapshot.map((snap) {
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

  // Retreive all products
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
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      notifyListeners();
    }

    _isFetchingProducts = false;
  }

  // Retrieve either exclusive or featured products.
  // Special can be either "exclusive" or "featured"
  Future fetchSpecialProducts(String special) async {
    try {
      // Reads firestore collection products
      final snap = await FirebaseQuery.getSpecialProducts(10, special);
      switch (special) {
        case 'featured':
          {
            _productFeaturedSnapshot.addAll(snap.docs);
          }
          break;
        case 'exclusive':
          {
            _productExclusiveSnapshot.addAll(snap.docs);
          }
          break;
        default:
          {
            _productSnapshot.addAll(snap.docs);
          }
          break;
      }
    } catch (error) {
      _errorMessage = error.toString();
    } finally {
      notifyListeners();
    }
  }

  Future massWriteProducts() async {
    FirebaseQuery.massWriteProducts();
  }
}
