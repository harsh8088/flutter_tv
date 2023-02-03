// import 'package:http/http.dart' as http;

import '../config/constants.dart';
import '../networking/api_provider.dart';

class MyRequestRepository {
  final ApiProvider _provider = ApiProvider();

  static final MyRequestRepository _repository = MyRequestRepository._();

  MyRequestRepository._();

  factory MyRequestRepository() {
    return _repository;
  }

  //display-tv
  // "2022-10-06"
  Future<dynamic> getOtp({
    required String deviceId,
  }) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
      };

      var body = {"device_id": deviceId};
      final response = await _provider.post(Constants.displayTv, headers, body);
      return response;
    } catch (e) {
      return e.toString();
    }
  }

  //display-services
  // "2022-10-06"
  Future<dynamic> getDisplayServices(
      {required String deviceId, required String deviceModel}) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': Constants.authToken
      };

      var body = {
        "device_id": deviceId,
        "battery_percentage": '90',
        "device_model_number": deviceModel
      };
      final response =
          await _provider.post(Constants.displayServices, headers, body);
      return response;
    } catch (e) {
      return e.toString();
    }
  }
}
