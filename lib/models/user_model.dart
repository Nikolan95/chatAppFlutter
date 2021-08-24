import 'package:chat_app/models/car_model.dart';

class UserModel {
  int id;
  String name;
  String surname;
  String company;
  String street;
  String city;
  String telefon;
  String email;
  String password;
  String imageUrl;
  List<CarModel> cars;

  UserModel({this.id, this.name, this.surname, this.company, this.street, this.city, this.telefon, this.email, this.imageUrl, this.password, this.cars});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    surname = json['surname'];
    company = json['company'];
    street = json['street'];
    city = json['city'];
    telefon = json['telefon'];
    email = json['email'];
    imageUrl = json['image_url'];
    if (json['cars'] != null) {
      cars = new List<CarModel>();
      //List<MessageModel> messages = [];
      json['cars'].forEach((v) {
        cars.add(new CarModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    surname = this.surname;
    company = this.company;
    street = this.street;
    city = this.city;
    telefon = this.telefon;
    data['email'] = this.email;
    data['image_url'] = this.imageUrl;
    //data['picture'] = this.imageUrl;
    return data;
  }
}
