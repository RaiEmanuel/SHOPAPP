class FeedbackProduct {
  int userId = 0;
  int productId = 0;
  String ? picture = "picture default";
  int star = 0;
  String comment = "comment";

  FeedbackProduct(
      {required this.userId,required  this.productId,required  this.picture,required  this.star,required  this.comment});

  FeedbackProduct.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    productId = json['product_id'];
    picture = json['picture'];
    star = json['star'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['picture'] = this.picture;
    data['star'] = this.star;
    data['comment'] = this.comment;
    return data;
  }
}
