class TermsAndConditions {
  int id;
  int messageId;
  String body;
  String createdAt;
  String updatedAt;

  TermsAndConditions(
      {this.id, this.messageId, this.body, this.createdAt, this.updatedAt});

  TermsAndConditions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageId = json['message_id'];
    body = json['body'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message_id'] = this.messageId;
    data['body'] = this.body;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
