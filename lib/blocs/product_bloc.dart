import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/firebase_query.dart';

class ProductBloc extends ChangeNotifier {
  final _productSnapshot = <DocumentSnapshot>[];
  String _errorMessage = '';
  int documentLimit = 10;
  bool _hasNext = true;
  bool _isFetchingProducts = false;

  Future fetchNextProducts() async {
    if (_isFetchingProducts) return;

    _isFetchingProducts = true;

    try {
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
