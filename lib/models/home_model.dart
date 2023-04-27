import 'package:carsa/models/favorite.dart';
import 'package:carsa/models/rate_response.dart';
import 'package:carsa/models/setting_model.dart';
import 'package:carsa/models/user_model.dart';

import 'cart.dart';

class HomeModel {
  List<Brand>? brands;
  List<Product>? sliders;
  List<Product>? products;
  List<CategoryModel>? categories;
  List<NeedModel>? needs;
  List<SittingModel>? sittings;
  List<CategoryWork>? categoriesWork;
  List<Workshops>? workshops;
  List<Favorite>? favorites;
  List<Cart>? carts;
  UserModel? user;
  HomeModel({this.brands, this.sliders, this.products, this.categories, this.sittings});

  HomeModel.fromJson(Map<String, dynamic> json) {
    if (json['brands'] != null) {
      brands = <Brand>[];
      json['brands'].forEach((v) {
        brands!.add(Brand.fromJson(v));
      });
    }
    if (json['sliders'] != null) {
      sliders = [];
      json['sliders'].forEach((v) {
        sliders!.add( Product.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Product>[];
      json['products'].forEach((v) {
        products!.add( Product.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <CategoryModel>[];
      json['categories'].forEach((v) {
        categories!.add(CategoryModel.fromJson(v));
      });
    }

    if (json['categoriesWork'] != null) {
      categoriesWork = [];
      json['categoriesWork'].forEach((v) {
        categoriesWork!.add(new CategoryWork.fromJson(v));
      });
    }
    if (json['workshops'] != null) {
      workshops = [];
      json['workshops'].forEach((v) {
        workshops!.add(new Workshops.fromJson(v));
      });
    }
    if (json['sittings'] != null) {
      sittings = [];
      json['sittings'].forEach((v) {
        sittings!.add( SittingModel.fromJson(v));
      });
    }
    if (json['favorites'] != null) {
      favorites = [];
      json['favorites'].forEach((v) {
        favorites!.add( Favorite.fromJson(v));
      });
    }
    if (json['carts'] != null) {
      carts =[];
      json['carts'].forEach((v) {
        carts!.add( Cart.fromJson(v));
      });
    }
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  <String, dynamic>{};
    if (brands != null) {
      data['brands'] = brands!.map((v) => v.toJson()).toList();
    }
    if (sliders != null) {
      data['sliders'] = sliders!.map((v) => v.toJson()).toList();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }

    if (needs != null) {
      data['needs'] = needs!.map((v) => v.toJson()).toList();
    }

    if (this.sittings != null) {
      data['sittings'] = this.sittings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Brand {
  int? id;
  String? name;
  String? image;

  Brand({this.id, this.name, this.image});

  Brand.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

class SliderModel {
  int? id;
  String? name;
  String? image;

  SliderModel({this.id, this.name, this.image});

  SliderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }





  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}



class NeedModel {
  int? id;
  String? name;
  String? image;

  NeedModel({this.id, this.name, this.image});

  NeedModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }





  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}

class CategoryModel {
  int? id;
  String? name;
  String? image;

  CategoryModel({this.id, this.name, this.image});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}



class Product {
  int? id;
  String? sellerId;
  String? name;
  String? detail;
  String? timeDelivery;
  bool? detailsPrice;
  bool? isCart;
  bool? isFav;
  var price;
  String? image;
  int? categoryId;
  int? brandId;
  int? offerId;
  int? status;

  Product(
      {this.id,
        this.sellerId,
        this.name,
        this.detail,
        this.isCart,
        this.isFav,
        this.detailsPrice,
        this.timeDelivery,
        this.offerId,
        this.price,
        this.image,
        this.categoryId,
        this.brandId,
        this.status});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sellerId = json['sellerId'];
    name = json['name'];
    detail = json['detail'];
    isCart = json['isCart'];
    isFav = json['isFav'];
    detailsPrice = json['detailsPrice'];
    timeDelivery = json['timeDelivery'];
    offerId = json['offerId'];
    price = json['price'];
    image = json['image'];
    categoryId = json['categoryId'];
    brandId = json['brandId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sellerId'] = this.sellerId;
    data['name'] = this.name;
    data['detail'] = this.detail;
    data['isCart'] = this.isCart;
    data['isFav'] = this.isFav;
    data['price'] = this.price;
    data['image'] = this.image;
    data['detailsPrice'] = this.detailsPrice;
    data['timeDelivery'] = this.timeDelivery;
    data['categoryId'] = this.categoryId;
    data['brandId'] = this.brandId;
    data['status'] = this.status;
    data['offerId'] =offerId;
    return data;
  }
}


class CategoryWork {
  int? id;
  String? name;

  CategoryWork({this.id, this.name});

  CategoryWork.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}


class Workshops {
  int? id;
  int? categoryId;
  String? name;
  String? desc;
  String? image;
  String? address;
  double? lat;
  double? rate;
  double? lng;
  String? phone;
  String? phoneWhats;
  int? status;

  Workshops(
      {this.id,
        this.categoryId,
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

  Workshops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryId = json['categoryId'];
    name = json['name'];
    desc = json['desc'];
    image = json['image'];
    address = json['address'];
    lat = json['lat'].toDouble();;
    rate = json['rate'].toDouble();
    lng = json['lng'].toDouble();
    phone = json['phone'];
    phoneWhats = json['phoneWhats'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
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

class WorkshopDetailsModel{

    Workshops? workshop;
  List<RateResponse>? rates;

  WorkshopDetailsModel({this.workshop, this.rates});

  WorkshopDetailsModel.fromJson(Map<String, dynamic> json) {
    workshop = json['workshop'] != null
        ? new Workshops.fromJson(json['workshop'])
        : null;
    if (json['rates'] != null) {
      rates = [];
      json['rates'].forEach((v) {
        rates!.add( RateResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.workshop != null) {
      data['workshop'] = this.workshop!.toJson();
    }
    if (this.rates != null) {
      data['rates'] = this.rates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
