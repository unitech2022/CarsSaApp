class SupportMessage{
late int id;
late String message;
late String userId;
late String sender;
late String date;

SupportMessage({  required this.message, required this.userId, required this.sender,required this.date});

SupportMessage.fromJson(Map<String, dynamic> json) {
id = json['id'];
userId = json['userId'];
message = json['message'];
sender = json['sender'];
date = json['date'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['message'] = this.message;
  data['userId'] = this.userId;
  data['sender'] = this.sender;
  data['date'] = this.date;
  return data;
}
}