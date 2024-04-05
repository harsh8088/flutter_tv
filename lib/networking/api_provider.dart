import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../config/constants.dart';
import '../config/session_manager.dart';
import 'api_response.dart';
import 'custom_exception.dart';

class ApiProvider {
  //FOR DEV
  // final String _baseUrl = Constants.baseUrl;

  //FOR UAT
  // final String _baseUrl = "https://";

  Future<dynamic> get(String url) async {
    try {
      final uri = Uri.parse(url);
      var mHeaders = {
        'Content-Type': 'application/json',
      };

      final token = await SessionManager().getToken();
      if (token.toString().isNotEmpty) {
        var headers = {
          'Authorization': token.toString(),
        };
        mHeaders.addAll(headers);
      }
      final response = await http.get(uri, headers: mHeaders);
      print('Get Request url: $uri');
      print('--> header: $mHeaders');
      print('<-- body: ${response.statusCode} , ${response.body}');
      return ApiResponse(
          statusCode: response.statusCode,
          data: json.decode(response.body.toString()),
          message: "");
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> post(String url, Map<String, String> headers,
      Map<String, dynamic> body) async {
    try {
      final uri = Uri.parse(url);
      var mHeaders = {
        'Content-Type': 'application/json',
      };
      mHeaders.addAll(headers);

      var mBody = json.encode(body);
      final response = await http.post(uri, headers: mHeaders, body: mBody);
      print('Post Request url: $uri');
      print('-->. header: $mHeaders');
      print('-->. body: $mBody');
      print('<--. res.body:${response.statusCode} , ${response.body}');
      print('<--. res.header:${response.headers.toString()}}');
      if (response.headers.containsKey("authorization")) {
        Constants.authToken = response.headers["authorization"]!;
      }
      return json.decode(response.body.toString());
    } on SocketException {
      print("Socket Exception");
      throw FetchDataException('No Internet connection');
    }
  }

  Future<dynamic> multipart(
      String url, Map<String, String> headers, Map<String, String> body) async {
    var postUri = Uri.parse(url);
    var request = http.MultipartRequest("POST", postUri);
    request.fields['user'] = 'blah';
    request.files.add(http.MultipartFile.fromBytes(
        'file', await File.fromUri(postUri).readAsBytes(),
        contentType: null));

    final Future<http.StreamedResponse> response = request.send();
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        print(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
