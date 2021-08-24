import 'package:chat_app/models/car_model.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/models/user_model.dart';

class ConversationModel {
  int id;
  UserModel user;
  CarModel car;
  String createdAt;
  List<MessageModel> messages;

  ConversationModel({this.id, this.user, this.car, this.createdAt, this.messages});

  ConversationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
    car = json['car'] != null ? new CarModel.fromJson(json['car']) : null;
    createdAt = json['created_at'];
    if (json['messages'] != null) {
      messages = new List<MessageModel>();
      //List<MessageModel> messages = [];
      json['messages'].forEach((v) {
        messages.add(new MessageModel.fromJson(v));
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
