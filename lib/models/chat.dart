import 'package:chat_app/models/car.dart';
import 'package:chat_app/models/chat_message.dart';
import 'package:chat_app/models/user.dart';

class Chat {
  int id;
  User user;
  Car car;
  String createdAt;
  List<ChatMessage> messages;

  Chat({this.id, this.user, this.car, this.createdAt, this.messages});

  Chat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    car = json['car'] != null ? new Car.fromJson(json['car']) : null;
    createdAt = json['created_at'];
    if (json['messages'] != null) {
      messages = new List<ChatMessage>();
      //List<MessageModel> messages = [];
      json['messages'].forEach((v) {
        messages.add(new ChatMessage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.car != null) {
      data['car'] = this.car.toJson();
    }
    data['created_at'] = this.createdAt;
    if (this.messages != null) {
      data['messages'] = this.messages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
