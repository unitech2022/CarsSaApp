class Comment {
  int? id;
  String? text;
  String? userId;
  int? sellerId;
  int? postId;
  int? accepted;
  String? createdAt;
  String? userName;
  String? phone;
  String? imageUrl;

  Comment(
      {this.id,
        this.text,
        this.userId,
        this.sellerId,
        this.postId,
        this.createdAt,
        this.userName,
        this.phone,
        this.accepted,
        this.imageUrl});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    userId = json['userId'];
    sellerId = json['sellerId'];
    postId = json['postId'];
    createdAt = json['createdAt'];
    userName = json['userName'];
    phone = json['phone'];
     accepted = json['accepted'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['text'] = this.text;
    data['userId'] = this.userId;
    data['sellerId'] = this.sellerId;
    data['postId'] = this.postId;
    data['createdAt'] = this.createdAt;
    data['userName'] = this.userName;
    data['phone'] = this.phone;
    data['imageUrl'] = this.imageUrl;
    return data;
  }
}
class ResponseComment {
   Comment? comment;
  String? nameWorkShop;
  String? imageUrlWorkShop;

  ResponseComment({this.comment, this.nameWorkShop, this.imageUrlWorkShop});

  ResponseComment.fromJson(Map<String, dynamic> json) {
    comment =
        json['comment'] != null ? new Comment.fromJson(json['comment']) : null;
    nameWorkShop = json['nameWorkShop'];
    imageUrlWorkShop = json['imageUrlWorkShop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.comment != null) {
      data['comment'] = this.comment!.toJson();
    }
    data['nameWorkShop'] = this.nameWorkShop;
    data['imageUrlWorkShop'] = this.imageUrlWorkShop;
    return data;
  }

}
