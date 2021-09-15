import 'package:chat_app/models/terms_and_conditions.dart';

import 'file.dart';
import 'offer_item.dart';

class ChatMessage {
  int id;
  String body;
  int read;
  int userId;
  int chatId;
  String acceptOffer;
  String createdAt;
  String updatedAt;
  String image;
  File file;
  List<OfferItem> offerItems;
  List<TermsAndConditions> termsAndConditions;

  ChatMessage(
      {this.id,
      this.body,
      this.read,
      this.userId,
      this.acceptOffer,
      this.chatId,
      this.createdAt,
      this.updatedAt,
      this.image,
      this.file,
      this.offerItems,
      this.termsAndConditions});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    read = json['read'];
    userId = json['user_id'];
    acceptOffer = json['accept_offer'];
    chatId = json['conversation_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    file = json['file'] != null ? new File.fromJson(json['file']) : null;
    if (json['offeritems'] != null) {
      offerItems = new List<OfferItem>();
      //List<MessageModel> messages = [];
      json['offeritems'].forEach((v) {
        offerItems.add(new OfferItem.fromJson(v));
      });
    }
    if (json['termsandconditions'] != null) {
      termsAndConditions = new List<TermsAndConditions>();
      //List<MessageModel> messages = [];
      json['termsandconditions'].forEach((v) {
        termsAndConditions.add(new TermsAndConditions.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body'] = this.body;
    data['read'] = this.read;
    data['user_id'] = this.userId;
    data['accept_offer'] = this.acceptOffer;
    data['conversation_id'] = this.chatId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    return data;
  }
}
