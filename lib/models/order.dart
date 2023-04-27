import 'package:carsa/models/address.dart';

class Order {
  int? id;
  String? userId;
  var price;
  int? status ,addressId;
  String? sellerId;
  String? createdAt;

  Order(
      {this.id,
        this.userId,
        this.price,
        this.status,
        this.sellerId,
        this.addressId,
        this.createdAt});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    price = json['price'];
    status = json['status'];
    addressId = json['addressId'];
    sellerId = json['sellerId'];
    createdAt = json['createdAt'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['price'] = this.price;
    data['addressId']= addressId ;
    data['status'] = this.status;
    data['sellerId'] = this.sellerId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
class ResponseOrder {
  Order? order;
  Address? address;


  ResponseOrder({this.order, this.address});

  ResponseOrder.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;


  }


}