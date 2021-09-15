class OfferItem {
  int id;
  int messageId;
  String articleNumber;
  String name;
  int amount;
  int price;
  int total;
  String createdAt;
  String updatedAt;

  OfferItem(
      {this.id,
      this.messageId,
      this.articleNumber,
      this.name,
      this.amount,
      this.price,
      this.total,
      this.createdAt,
      this.updatedAt});

  OfferItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageId = json['message_id'];
    articleNumber = json['articleNumber'];
    name = json['name'];
    amount = json['amount'];
    price = json['price'];
    total = json['total'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message_id'] = this.messageId;
    data['articleNumber'] = this.articleNumber;
    data['name'] = this.name;
    data['amount'] = this.amount;
    data['price'] = this.price;
    data['total'] = this.total;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
