import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shoapp/model/PurchasedProduct.dart';
import 'package:shoapp/model/Address.dart';
import 'package:shoapp/model/Feedback.dart';
import 'package:shoapp/model/Product.dart';
import 'package:shoapp/model/User.dart';

//import 'package:shoapp/Aux'

/* classe auxiliar apenas para enviar pela api */
class AuxPurchasedProduct{
  int id, quantity;
  List<int> idsColors;

  AuxPurchasedProduct({required this.id, required this.quantity, required this.idsColors});
}

class Connection{

  //static String _host = "jsonplaceholder.typicode.com";
  static Future<String> getAttr() async{
    var client = http.Client();
    await Future.delayed(Duration(seconds: 3), ()=>"a");
    var res = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/users/1"));
    //print('Response body: ${response.body}');
    return res.body;
  }

  static Future<String> teste() async{
    String url = Uri.encodeFull("https://api.api-futebol.com.br/v1/campeonatos/10/tabela");
    Map<String, String> header = {'Authorization':'Bearer live_c11420093039a0b278ebc81933132e'};
    http.Response x = await http.get(Uri.parse(url), headers: header);
    //print("$x");
    //print("---------------------------------");
    //print("${x.body}");
    return x.body;
  }

  static Future<Credential> auth(String login, String password) async {
    var client = http.Client();
    try {
      var uriResponse = await client.post(Uri.parse('https://fakeecommerceapi.herokuapp.com/auth'),
          body: {'email': login, 'password': password});
      Credential credential = Credential.fromJson(jsonDecode(uriResponse.body));
      return credential;
    } finally {
    client.close();
    }
  }

  static Future<User> me(String type, String token) async {
    var client = http.Client();
    try {
      var uriResponse = await client.get(Uri.parse('https://fakeecommerceapi.herokuapp.com/me'),
      headers: {"Authorization":type+" "+token});
      User meUser = User.fromJson(jsonDecode(uriResponse.body));
      return meUser;
    } finally {
      client.close();
    }
  }

  static Future<User> getUser(int idUser) async {
    var client = http.Client();
    try {
      var uriResponse = await client.get(Uri.parse('https://fakeecommerceapi.herokuapp.com/users/${idUser}'));
          //headers: {"Authorization":type+" "+token});
      print("usuario buscadoooo = ${jsonDecode(uriResponse.body)}");
      User user = User.fromJson(jsonDecode(uriResponse.body));
      return user;
    } finally {
      client.close();
    }
  }

  static Future<List<Product>> products() async {
    var client = http.Client();
    try {
      var uriResponse = await client.get(Uri.parse('https://fakeecommerceapi.herokuapp.com/products'));
      List<dynamic> listDynamic = jsonDecode(uriResponse.body);
      List<Product> listProduct = [];
      for(dynamic d in listDynamic){
        listProduct.add(Product.fromJson(d));
      }
      return Future.value(listProduct);
    } finally {
      client.close();
    }
  }

  static Future<void> postFeedback(String token, FeedbackProduct feedback) async{
    var client = http.Client();
    var uriResponse = await client.post(Uri.parse('https://fakeecommerceapi.herokuapp.com/feedbacks'),
        body: jsonEncode(feedback.toJson()),
        headers: {
          "Authorization":"bearer "+token,
          'Content-Type': 'application/json; charset=UTF-8',
    });
    print("postouuu feed? ${uriResponse.body}");
  }

  static Future<List<FeedbackProduct>> ? feedbacks(int idProduct) async {
    var client = http.Client();
    try {
      var uriResponse = await client.get(Uri.parse('https://fakeecommerceapi.herokuapp.com/feedbacks/${idProduct}'));
      List<dynamic> listDynamic = jsonDecode(uriResponse.body);

      print("dunamico = ${listDynamic}");
      //Feedback f = Feedback.fromJson(listDynamic[0]);

      List<FeedbackProduct> listFeedback = [];
      for(dynamic d in listDynamic){
        listFeedback.add(FeedbackProduct.fromJson(d));
        print("fffffffffffffffffff = ${d}");
      }
      return Future.value(listFeedback);
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
      print("comprooooooooooou???? ${uriResponse.body}");
      return uriResponse.body;
    } finally {
      client.close();
    }
  }

  static Future<String> getAllPurchases(String type, String token)async{
    var client = http.Client();
    var uriResponse = await client.get(
        Uri.parse('https://fakeecommerceapi.herokuapp.com/purchases'),
        headers: {"Authorization":type+" "+token}
    );

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


