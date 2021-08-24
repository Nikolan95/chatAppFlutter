import 'dart:convert';

import 'package:chat_app/models/car_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/providers/base_provider.dart';
import 'package:chat_app/services/user_service.dart';
import 'package:image_picker/image_picker.dart';

class UserProvider extends BaseProvider {
  UserModel _user = UserModel();
  UserService _userService = UserService();
  List<CarModel> _cars = [];
  List<CarModel> get cars => _cars;

  UserModel get user => _user;

  setUser(UserModel user) {
    _user = user;
    notifyListeners();
  }

  Future<bool> updateUser() async {
    setBusy(true);
    var response = await _userService.updateUser(_user);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setUser(UserModel.fromJson(data['data']));

      setBusy(false);
      return true;
    }
    if (response.statusCode == 422) {
      var message = data['errors']['email'][0];
      print(message);
      setMessage(message);
      return false;
    }
    setBusy(false);
    return false;
  }

  Future<void> pickImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    //print(image);
    // return;
    var response = await _userService.uploadImage(image);
    //print(response.body);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(data);
      setUser(UserModel.fromJson(data['data']));
      //print(_user.toJson());
      setBusy(false);
      return true;
    }
  }

  Future<void> setFcmToken(String token) async {
    _userService.setFcmToken(token);
  }

  Future<void> storeCar(CarModel car) async {
    setBusy(true);
    var response = await _userService.storeCar(car);
    print(response.body);
    if(response.statusCode == 201){
      setBusy(false);
    }
      setBusy(false);
  }
}