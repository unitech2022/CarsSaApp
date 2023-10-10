
import 'home_model.dart';

class ResponseModel  {
  List<Workshops>? items;
  int? currentPage;
  int? totalPage;

  ResponseModel({this.items, this.currentPage, this.totalPage});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = [];
      json['items'].forEach((v) {
        items!.add( Workshops.fromJson(v));
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

