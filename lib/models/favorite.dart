class Favorite {
  int? id;
  int? productId;
  String? sellerId;
  String? name;
  String? userId;
  String? detail;
  bool? isCart;
  bool? isFav;
  var price;
  String? image;
  int? categoryId;
  int? brandId;
  int? status;

  Favorite(
      {this.id,
        this.productId,
        this.sellerId,
        this.name,
        this.userId,
        this.detail,
        this.isCart,
        this.isFav,
        this.price,
        this.image,
        this.categoryId,
        this.brandId,
        this.status});

  Favorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    sellerId = json['sellerId'];
    name = json['name'];
    userId = json['userId'];
    detail = json['detail'];
    isCart = json['isCart'];
    isFav = json['isFav'];
    price = json['price'];
    image = json['image'];
    categoryId = json['categoryId'];
    brandId = json['brandId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['productId'] = this.productId;
    data['sellerId'] = this.sellerId;
    data['name'] = this.name;
    data['userId'] = this.userId;
    data['detail'] = this.detail;
    data['isCart'] = this.isCart;
    data['isFav'] = this.isFav;
    data['price'] = this.price;
    data['image'] = this.image;
    data['categoryId'] = this.categoryId;
    data['brandId'] = this.brandId;
    data['status'] = this.status;
    return data;
  }
}
