class Product {
  int id = 0;
  String name = "product default";
  String description = "description default";
  double value = 0;
  String picture = "https://www.polibras.com.br/assets/images/products/0224.png";
  List<Categories> categories = [];
  List<int> colors = [];

  Product(
      {required this.id,
        required this.name,
        required this.description,
        required this.value,
        required this.picture,
        required this.categories,
        required this.colors});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    value = double.parse(json['value'].toString());
    picture = json['picture'];
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }
    colors = json['colors'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['value'] = this.value;
    data['picture'] = this.picture;
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }
    data['colors'] = this.colors;
    return data;
  }
}

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
}