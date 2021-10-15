import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shoapp/PurchasedProduct.dart';
import 'package:shoapp/Address.dart';
import 'package:shoapp/PurchasedProduct.dart';
//import 'package:shoapp/Aux'

/* classe auxiliar apenas para enviar pela api */
class AuxPurchasedProduct{
  int id, quantity;
  List<int> idsColors;

  AuxPurchasedProduct({required this.id, required this.quantity, required this.idsColors});
}

class Connection{

  static String _host = "jsonplaceholder.typicode.com";
  static Future<String> getAttr() async{
    var client = http.Client();
    await Future.delayed(Duration(seconds: 3), ()=>"a");
    var res = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/users/1"));
    //print('Response body: ${response.body}');
    return res.body;
  }

  static Future<String> auth(String login, String password) async {
    var client = http.Client();
    try {
      var uriResponse = await client.post(Uri.parse('https://fakeecommerceapi.herokuapp.com/auth'),
          body: {'email': login, 'password': password});
      return uriResponse.body;

    } finally {
    client.close();
    }
  }

  static Future<String> me(String type, String token) async {
    var client = http.Client();
    try {
      var uriResponse = await client.get(Uri.parse('https://fakeecommerceapi.herokuapp.com/me'),
      headers: {"Authorization":type+" "+token});
      return uriResponse.body;
    } finally {
      client.close();
    }
  }

  static Future<String> products() async {
    var client = http.Client();
    try {
      var uriResponse = await client.get(Uri.parse('https://fakeecommerceapi.herokuapp.com/products'));
          //headers: {"Authorization":type+" "+token});
      return uriResponse.body;
    } finally {
      client.close();
    }
  }

  static Future<String> purchase(String type, String token, List<PurchasedProduct> productPurchaseList, Address address) async {
    /* pega ids */
    var client = http.Client();
    try {
      List<Products> ps = [];
      for(PurchasedProduct p in productPurchaseList){
        ps.add(Products(id: p.id,quantity: p.quantity, colors: p.colors));
      }
      PurchasedProductAux px = PurchasedProductAux(products: ps, latitude: address.latitude, longitude: address.longitude, street: address.street);

      var uriResponse = await client.post(Uri.parse('https://fakeecommerceapi.herokuapp.com/purchases'),
          body: jsonEncode(px),
      headers: {
        "Authorization":type+" "+token,
        'Content-Type': 'application/json; charset=UTF-8',
        //"Content-Type":"text/plain"
        //'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      });
      return uriResponse.body;
    } finally {
      client.close();
    }
  }

  static Future<String> getAllPurchases()async{
    var client = http.Client();
    var uriResponse = await client.get(Uri.parse('https://fakeecommerceapi.herokuapp.com/purchases'));
    //headers: {"Authorization":type+" "+token});
    print("trouxe xxxxxxxx ${uriResponse.body}");

    return uriResponse.body;
  }
}

class PurchasedProductAux {
  late List<Products> products;
  String latitude = "0";
  String longitude = "0";
  String street = "Rua do racha";

  PurchasedProductAux(
      {required this.products,required this.latitude, required this.longitude,required this.street});

  PurchasedProductAux.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products.add(new Products.fromJson(v));
      });
    }
    latitude = json['latitude'];
    longitude = json['longitude'];
    street = json['street'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['street'] = this.street;
    return data;
  }
}

class Products {
  int id = 0;
  int quantity = 0;
  late List<int> colors = [];

  Products({required this.id, required this.quantity, required this.colors});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    colors = json['colors'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quantity'] = this.quantity;
    data['colors'] = this.colors;
    return data;
  }
}


