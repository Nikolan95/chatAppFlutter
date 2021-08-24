import 'dart:io';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

class Api {
    static final _api = Api._internal();

    factory Api(){
        return _api;
    }
    Api._internal();

    String token ;
    String baseUrl = '195.4.160.243';
    String path = 'atevChatApp/public/api';

    Future<http.Response> httpGet(String endPath,{Map<String, String> query}){
        Uri url = Uri.http(baseUrl, '$path/$endPath');

        if(query != null){
            url = Uri.http(baseUrl, '$path/$endPath', query);
        }
        return http.get(url, headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
        });
    }

    Future<http.Response> httpPost(String endPath,Object body){
        Uri url = Uri.http(baseUrl, '$path/$endPath');

        return http.post(url,body: body, headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
        });
    }
    Future<http.Response> httpPostWithFile(String endPath, {File file}) async {
    Map<String, String> headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
    };
    var uri = Uri.parse("http://${this.baseUrl}/${this.path}/$endPath");
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