class WorkshopModel {
  Workshop? workshop;
  List<Offer>? offers;
  List<Post>? posts;

  WorkshopModel({this.workshop, this.offers, this.posts});

  WorkshopModel.fromJson(Map<String, dynamic> json) {
    workshop = json['workshop'] != null
        ?  Workshop.fromJson(json['workshop'])
        : null;
    if (json['offers'] != null) {
      offers = [];
      json['offers'].forEach((v) {
        offers!.add(new Offer.fromJson(v));
      });
    }
    if (json['posts'] != null) {
      posts = [];
      json['posts'].forEach((v) {
        posts!.add( Post.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.workshop != null) {
      data['workshop'] = this.workshop!.toJson();
    }
    if (this.offers != null) {
      data['offers'] = this.offers!.map((v) => v.toJson()).toList();
    }
    if (this.posts != null) {
      data['posts'] = this.posts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Workshop {
  int? id;
  int? categoryId;
  String? userId;
  String? name;
  String? desc;
  String? image;
  String? address;
  double? lat;
  int? rate;
  double? lng;
  String? phone;
  String? phoneWhats;
  int? status;

  Workshop(
      {this.id,
      this.categoryId,
      this.userId,
      this.name,
      this.desc,
      this.image,
      this.address,
      this.lat,
      this.rate,
      this.lng,
      this.phone,
      this.phoneWhats,
      this.status});

  Workshop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    userId = json['userId'];
    name = json['name'];
    desc = json['desc'];
    image = json['image'];
    address = json['address'];
    lat = json['lat'];
    rate = json['rate'];
    lng = json['lng'];
    phone = json['phone'];
    phoneWhats = json['phoneWhats'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['desc'] = this.desc;
    data['image'] = this.image;
    data['address'] = this.address;
    data['lat'] = this.lat;
    data['rate'] = this.rate;
    data['lng'] = this.lng;
    data['phone'] = this.phone;
    data['phoneWhats'] = this.phoneWhats;
    data['status'] = this.status;
    return data;
  }
}

class Offer {
  int? id;
  String? text;
  String? userId;
  String? phone;
  int? workshopId;
  int? postId;
  int? accepted;
  String? createdAt;

  Offer(
      {this.id,
      this.text,
      this.userId,
      this.phone,
      this.workshopId,
      this.postId,
      this.accepted,
      this.createdAt});

  Offer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    userId = json['userId'];
    phone = json['phone'];
    workshopId = json['workshopId'];
    postId = json['postId'];
    accepted = json['accepted'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['userId'] = this.userId;
    data['phone'] = this.phone;
    data['workshopId'] = this.workshopId;
    data['postId'] = this.postId;
    data['accepted'] = this.accepted;
    data['createdAt'] = this.createdAt;
    return data;
  }
}

class Post {
  int? id;
  int? acceptedOfferId;
  String? userId;
  int? status;
  String? images;
  String? phone;
  String? modelCar;
  String? colorCar;
   double? lat;
  double? lng;
  String? nameCar;
  String? desc;
  String? createdAt;

  Post(
      {this.id,
      this.acceptedOfferId,
      this.userId,
      this.status,
      this.images,
      this.phone,
      this.lat,
      this.lng,
      this.modelCar,
      this.colorCar,
      this.nameCar,
      this.desc,
      this.createdAt});

  Post.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    acceptedOfferId = json['acceptedOfferId'];
    userId = json['userId'];
    status = json['status'];
    images = json['images'];
    phone = json['phone'];
    lat = json['lat'].toDouble();
    lng = json['lng'].toDouble();
    modelCar = json['modelCar'];
    colorCar = json['colorCar'];
    nameCar = json['nameCar'];
    desc = json['desc'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['acceptedOfferId'] = this.acceptedOfferId;
    data['userId'] = this.userId;
    data['status'] = this.status;
    data['images'] = this.images;
    data['phone'] = this.phone;
    data['modelCar'] = this.modelCar;
    data['colorCar'] = this.colorCar;
    data['nameCar'] = this.nameCar;
    data['desc'] = this.desc;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
