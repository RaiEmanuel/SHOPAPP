import 'package:flutter/material.dart';

class PurchasedProduct {
  final int id;
  final String url, title, desc;
  final double value;
  int quantity;
  List<int> colors;
  bool favorite;

  PurchasedProduct({
    required this.id,
    required this.url,
    required this.title,
    required this.desc,
    this.value = 0,
    this.favorite = false,
    this.quantity = 1,
    this.colors = const [1]
  });

  Color getColor(){
    int idColor = colors[0];
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
