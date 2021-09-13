import 'package:chat_app/models/terms_and_conditions_model.dart';

import 'file_model.dart';
import 'offeritem_model.dart';

class MessageModel   {
  int id;
  String body;
  int read;
  int userId;
  int conversationId;
  String acceptOffer;
  String createdAt;
  String updatedAt;
  String image;
  FileModel file;
  List<OfferItemModel> offerItems;
  List<TermsAndConditionsModel> termsAndConditions;

  MessageModel  ({
    this.id,
    this.body,
    this.read,
    this.userId,
    this.acceptOffer,
    this.conversationId,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.file,
    this.offerItems,
    this.termsAndConditions
  });

  MessageModel  .fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    read = json['read'];
    userId = json['user_id'];
    acceptOffer = json['accept_offer'];
    conversationId = json['conversation_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    image = json['image'];
    file = json['file'] != null ? new FileModel.fromJson(json['file']) : null;
    if (json['offeritems'] != null) {
      offerItems = new List<OfferItemModel>();
      //List<MessageModel> messages = [];
      json['offeritems'].forEach((v) {
        offerItems.add(new OfferItemModel.fromJson(v));
      });
    }
    if (json['termsandconditions'] != null) {
      termsAndConditions = new List<TermsAndConditionsModel>();
      //List<MessageModel> messages = [];
      json['termsandconditions'].forEach((v) {
        termsAndConditions.add(new TermsAndConditionsModel.fromJson(v));
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
    data['conversation_id'] = this.conversationId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image'] = this.image;
    return data;
  }
}
