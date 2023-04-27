import 'package:carsa/models/home_model.dart';

class ResponsePagination {
  List<Product>? items;
  int? currentPage;
  int? totalPage;

  ResponsePagination({this.items, this.currentPage, this.totalPage});

  ResponsePagination.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add( Product.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = currentPage;
    data['totalPage'] = totalPage;
    return data;
  }
}
