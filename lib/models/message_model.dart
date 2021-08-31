import 'dart:ui';
import 'offeritem_model.dart';

class MessageModel   {
  int id;
  String body;
  int read;
  int userId;
  int conversationId;
  String createdAt;
  String updatedAt;
  String image;
  List<OfferItemModel> offerItems;

  MessageModel  ({
    this.id,
    this.body,
    this.read,
    this.userId,
    this.conversationId,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.offerItems
  });

  MessageModel  .fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    read = json['read'] == 'false' ? 0 : 1;
    userId = json['user_id'];
    conversationId = json['conversation_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    if (json['offeritems'] != null) {
      offerItems = new List<OfferItemModel>();
      //List<MessageModel> messages = [];
      json['offeritems'].forEach((v) {
        offerItems.add(new OfferItemModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body'] = this.body;
    data['read'] = this.read;
    data['user_id'] = this.userId;
    data['conversation_id'] = this.conversationId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    return data;
  }
}
