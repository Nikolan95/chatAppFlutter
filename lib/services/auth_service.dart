import 'package:chat_app/models/user.dart';
import 'package:chat_app/services/base_api.dart';
import 'package:http/http.dart' as http;

class AuthService extends BaseApi {
  Future<http.Response> getUser() async {
    return await api.httpGet('user');
  }

  Future<http.Response> login(String email, password) async {
    return await api
        .httpPost('sanctum/token', {'email': email, 'password': password});
  }

  Future<http.Response> register(User user) async {
    return await api.httpPost('register', {
      'name': user.name,
      'company': user.company,
      'street': user.street,
      'city': user.city,
      'phoneNumber': user.phoneNumber,
      'email': user.email,
      'password': user.password
    });
  }

  Future<http.Response> logout() async {
    return await api.httpPost('logout', {});
  }
}
