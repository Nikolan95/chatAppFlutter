import 'dart:convert';

import 'package:chat_app/models/car.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/providers/base_provider.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/user_service.dart';
import 'package:image_picker/image_picker.dart';

class UserProvider extends BaseProvider {
  User _user = User();
  UserService _userService = UserService();
  AuthService _authService = AuthService();
  List<Car> _cars = [];
  List<Car> get car => _cars;
  // CarModel _car = CarModel();
  // CarModel get car => _car;

  User get user => _user;

  setUser(User user) {
    _user = user;
    notifyListeners();
  }

  setCar(Car car) {
    for (var i = 0; i < _user.cars.length; i++) {
      if (_user.cars[i].id == car.id) {
        _user.cars[i] = car;
        notifyListeners();
      }
    }
    notifyListeners();
  }

  Future<bool> updateUser() async {
    setBusy(true);
    var response = await _userService.updateUser(_user);
    print(response);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setUser(User.fromJson(data['data']));
      print(data['data']);
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
    print(image);
    // return;
    var response = await _userService.uploadImage(image);
    print(response.body);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(data);
      setUser(User.fromJson(data['data']));
      print(_user.toJson());
      setBusy(false);
      return true;
    }
  }

  Future<void> setFcmToken(String token) async {
    _userService.setFcmToken(token);
  }

  Future<void> storeCar(Car car) async {
    setBusy(true);
    var response = await _userService.storeCar(car);
    var data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 201) {
      _user.cars.add(Car.fromJson(data['data']));

      notifyListeners();
      setBusy(false);
    }
    setBusy(false);
  }

  Future<bool> updateCar(Car car) async {
    setBusy(true);
    var response = await _userService.updateCar(car);
    //var response2 = await _authService.getUser();
    //print(response);
    var data = jsonDecode(response.body);
    //print(_cars.first.manufacturerAndBrand);
    if (response.statusCode == 200) {
      setCar(Car.fromJson(data['data']));
      //print(data['data']);
      setBusy(false);
      return true;
    }
    if (response.statusCode == 422) {
      var message = data['errors'];
      print(message);
      setMessage(message);
      return false;
    }
    setBusy(false);
    return false;
  }
}
