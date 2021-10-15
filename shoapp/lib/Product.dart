class Product {
  final int id;
  final String url, title, desc;
  final double value;
  final bool favorite;

  Product({
    required this.id,
    required this.url,
    required this.title,
    required this.desc,
    this.value = 0,
    this.favorite = false,
  });
}
