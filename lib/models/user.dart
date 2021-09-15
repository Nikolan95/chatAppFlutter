import 'package:chat_app/models/car.dart';

class User {
  int id;
  String name;
  String company;
  String street;
  String city;
  String phoneNumber;
  String email;
  String password;
  String imageUrl;
  List<Car> cars;

  User(
      {this.id,
      this.name,
      this.company,
      this.street,
      this.city,
      this.phoneNumber,
      this.email,
      this.imageUrl,
      this.password,
      this.cars});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    company = json['company'];
    street = json['street'];
    city = json['city'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    imageUrl = json['image_url'];
    if (json['cars'] != null) {
      cars = new List<Car>();
      //List<MessageModel> messages = [];
      json['cars'].forEach((v) {
        cars.add(new Car.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['company'] = this.company;
    data['street'] = this.street;
    data['city'] = this.city;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['image_url'] = this.imageUrl;
    //data['picture'] = this.imageUrl;
    return data;
  }
}
