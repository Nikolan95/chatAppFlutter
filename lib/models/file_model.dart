class FileModel {
  int id;
  int messageId;
  String name;
  String filePath;
  String createdAt;
  String updatedAt;

  FileModel(
      {this.id,
      this.messageId,
      this.name,
      this.filePath,
      this.createdAt,
      this.updatedAt});

  FileModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageId = json['message_id'];
    name = json['name'];
    filePath = json['file_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message_id'] = this.messageId;
    data['name'] = this.name;
    data['file_path'] = this.filePath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}