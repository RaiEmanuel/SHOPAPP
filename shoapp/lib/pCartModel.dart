import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:shoapp/PurchasedProduct.dart';

class PCartModel extends ChangeNotifier {
  final List<PurchasedProduct> _productsList = [];

  UnmodifiableListView<PurchasedProduct> get products =>
      UnmodifiableListView(_productsList);
  double totalPrice = 0;

  int getQuantity() {
    return _productsList.length;
  }

  void setTotalPrice(double totalPrice) {
    this.totalPrice = totalPrice;
    notifyListeners();
  }

  void remove(PurchasedProduct product) {
    _productsList.remove(product);
    totalPrice -= product.value;
    notifyListeners();
  }

  bool add(PurchasedProduct product) {
    for(PurchasedProduct p in _productsList){
      if(p.id == product.id){//duplicado
        return false;
      }
    }
    print("nao tem");
    _productsList.add(product);
    totalPrice += product.value;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
    return true;
    //if(!_productsList.contains(product)){

      //return true;
    //}
    //return false;
  }

  /// Removes all items from the cart.
  void removeAll() {
    _productsList.clear();
    totalPrice = 0;
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  Color getColor(int index){
    int idColor = _productsList[index].colors[0];
    switch(idColor){
      case 2:
        return Colors.black;
      case 3:
        return Colors.blueAccent;
      case 4:
        return Colors.redAccent;
      case 6:
        return Colors.grey;
    }
    return Colors.black;
  }
}
