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
}
