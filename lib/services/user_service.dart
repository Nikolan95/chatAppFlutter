import 'package:chat_app/models/car_model.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/services/base_api.dart';
import 'package:http/http.dart' as http;

class UserService extends BaseApi {
  Future<http.Response> updateUser(UserModel user) async {
    return await api
        .httpPost('update', {
          'name': user.name,
          'company': user.company,
          'street': user.street,
          'city': user.city,
          'phoneNumber': user.phoneNumber,
        });
  }

  Future<http.Response> uploadImage(var file) async {
    return await api.httpPostWithFile('upload', file: file);
  }

  Future<http.Response> setFcmToken(String token) async {
    return await api.httpPost('fcm', {'fcm_token': token.toString()});
  }
  Future<http.Response> storeCar(CarModel car) async {
    return await api.httpPost('cars', {
      'first_registration': car.firstRegistration,
      'vehicle_identification_number': car.vehicleIdentificationNumber,
      'manufacturer_and_brand': car.manufacturerAndBrand,
      'license_number': car.licenseNumber,
      'holder_name': car.holderName,
      'holder_city': car.holderCity,
      'holder_postcode': car.holderPostcode,
      'holder_street': car.holderStreet,
      'owner_name': car.ownerName,
      'user_id': car.userId.toString()
    });
  }
}