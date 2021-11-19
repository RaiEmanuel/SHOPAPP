import 'package:json_annotation/json_annotation.dart';
part 'ProductSqlite.g.dart';

@JsonSerializable()
class ProductSqlite {
  int id = 0;
  String name = "product default";
  String description = "description default";
  double value = 0;
  String picture = "https://www.polibras.com.br/assets/images/products/0224.png";
  //List<Categories> categories = [];
  //List<int> colors = [];

  ProductSqlite(
      {this.id = 0,
        required this.name,
        required this.description,
        required this.value,
        required this.picture});

  factory ProductSqlite.fromJson(Map<String, dynamic> json) => _$ProductSqliteFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProductSqliteToJson(this);
}

/*
class Categories {
  int id = 0;
  String name = "category default";

  Categories({required this.id,required this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}*/