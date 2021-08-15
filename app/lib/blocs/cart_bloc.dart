import 'package:flutter/material.dart';

import '../models/product_data.dart';

class CartBloc extends ChangeNotifier {
  static List<ProductData> _cartItems = [];

  int get quantity {
    return _cartItems.length;
  }

  List<ProductData> get cartItems {
    return _cartItems;
  }

  void addToCart(ProductData product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(ProductData product) {
    _cartItems.remove(product);
    notifyListeners();
  }

  bool cartContains(ProductData product) {
    return _cartItems.contains(product);
  }
  void clearCart() {
      _cartItems.clear();
  }
}
