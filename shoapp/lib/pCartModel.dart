import 'dart:collection';
import 'package:flutter/material.dart';
import 'Product.dart';

class CartModel extends ChangeNotifier {
  final List<Product> _productsList = [];

  UnmodifiableListView<Product> get products =>
      UnmodifiableListView(_productsList);

  double totalPrice = 0;

  int getQuantity() {
    return _productsList.length;
  }

  void setTotalPrice(double totalPrice) {
    this.totalPrice = totalPrice;
    notifyListeners();
  }

  void remove(Product product) {
    _productsList.remove(product);
    totalPrice -= product.value;
    notifyListeners();
  }

  void add(Product product) {
    _productsList.add(product);
    totalPrice += product.value;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _productsList.clear();
    totalPrice = 0;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}
