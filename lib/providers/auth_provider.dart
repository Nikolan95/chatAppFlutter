import 'dart:convert';

import 'package:chat_app/models/car_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/providers/base_provider.dart';
import 'package:chat_app/providers/locator.dart';
import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/services/api.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends BaseProvider{
  AuthService _authService = AuthService();
  UserProvider _userProvider = locator<UserProvider>();
  Api _api = Api();
  UserModel _user = UserModel();
  List<CarModel> _cars = [];
  List<CarModel> get cars => _cars;

  UserModel get user => _user;

  setUser(UserModel user){
    _user = user;
  }

  Future<bool> getUser() async {
    setBusy(true);
    bool tokenExists = await getToken();
    if(tokenExists){
      var response = await _authService.getUser();
        print(response.statusCode);
        var data = jsonDecode(response.body);
      if(response.statusCode == 200){
        print(response.body);
        _userProvider.setUser(UserModel.fromJson(data['data']));
        print(_userProvider);
        return true;
      }
      else
      setBusy(false); 
      return false;
    }
    setBusy(false);
    return false;
  }
  Future<bool> getToken()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('access_token');
    _api.token = token;
    if(token != null){
      _api.token = token;
      return true;
    }
    return false;
  }
  Future<void> saveToken(String token)async{
    SharedPreferences prefs= await SharedPreferences.getInstance();
    prefs.remove('access_token');
    prefs.setString('access_token', token);
    _api.token = token;
  }
  Future<bool> login(String email, password)async{
    setBusy(true);
    var response = await _authService.login(email.trim(), password.trim());
    print(response.statusCode);
    print(response.body);
    //var data = jsonDecode(response.body);
    String data = (response.body).toString();
    if (response.statusCode == 200) {
      //saveToken(data['access_token']);
      saveToken(data);
      getUser();
      setBusy(false);
      return true;
    } else if (response.statusCode == 400) {
      setMessage('error');
      return false;
    }
    setBusy(false);
    return false;
  }
  Future<bool> register()async{
    setBusy(true);

    var response = await _authService.register(_user);
    print(response.body);
      var json = jsonDecode(response.body);
    if(response.statusCode == 201){
      var result = await login(_user.email, _user.password);
      if(result){
        _user = UserModel.fromJson(json['data']);
        return true;
      }else
      return false;
    }
    if(response.statusCode == 422){
      var message = json['errors']['email'][0];
      setMessage(message);
      return false;
    }
    setBusy(false);
    return false;
  }
  Future<void> logout()async{
    await _authService.logout();
    SharedPreferences prefs= await SharedPreferences.getInstance();
    prefs.remove('access_token');
  }
}