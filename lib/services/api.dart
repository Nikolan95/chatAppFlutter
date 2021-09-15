import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class Api {
  static final _api = Api._internal();

  factory Api() {
    return _api;
  }
  Api._internal();

  //IOS Simulator
  //String devUrl = 'localhost:8000';

  //Android Simulator
  String devUrl = '10.0.2.2:8000';

  //Live
  //String devUrl = 'app.atev.de';

  String path = '/api';
  String token;

  Future<http.Response> httpGet(String endPath, {Map<String, String> query}) {
    Uri url = Uri.http(devUrl, '$path/$endPath');

    if (query != null) {
      url = Uri.http(devUrl, '$path/$endPath', query);
    }
    return http.get(url, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
  }

  Future<http.Response> httpPost(String endPath, Object body) {
    Uri url = Uri.http(devUrl, '$path/$endPath');

    return http.post(url, body: body, headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
  }

  Future<http.Response> httpPostWithFile(String endPath, {File file}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var uri = Uri.parse("http://${this.devUrl}/${this.path}/$endPath");
    var length = await file.length();
    http.MultipartRequest request = new http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..files.add(
        http.MultipartFile('file', file.openRead(), length,
            filename: basename(file.path)),
      );
    return await http.Response.fromStream(await request.send());
  }
}
