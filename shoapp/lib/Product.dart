class Product {
  final String url, title, desc;
  final double value;
  bool favorite;

  Product({
    required this.url,
    required this.title,
    required this.desc,
    this.value = 0,
    this.favorite = false,
  });
}
