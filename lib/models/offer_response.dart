import 'package:carsa/models/comment.dart';

import 'package:carsa/models/workshop_model.dart';

import 'home_model.dart';

class OfferResponse {
  Comment? offer;
  Workshops? workshop;
Post? post;
  OfferResponse({this.offer, this.workshop,this.post});

  OfferResponse.fromJson(Map<String, dynamic> json) {
    offer = json['offer'] != null ?  Comment.fromJson(json['offer']) : null;
    workshop = json['workshop'] != null
        ?  Workshops.fromJson(json['workshop'])
        : null;
        post = json['post'] != null ? new Post.fromJson(json['post']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.offer != null) {
      data['offer'] = this.offer!.toJson();
    }
    if (this.workshop != null) {
      data['workshop'] = this.workshop!.toJson();
    }
    return data;
  }
}