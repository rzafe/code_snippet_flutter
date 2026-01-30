import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/_model.dart';

class HTTPResponse {
  static HTTPResponse? _instance;
  factory HTTPResponse() => _instance ??= HTTPResponse._();

  HTTPResponse._();

  dynamic response(http.Response response) {
    final decoded = json.decode(response.body.toString());
    if (response.statusCode == 200) {
      return APIResult(
        message: decoded['Message'] ?? decoded['message'],
        // jwt: decoded['JWT'] ?? decoded['jwt'],
        profileId: decoded['profile_id'] ?? decoded['user_profile_id'] ?? decoded['user_id'],
        // userStatus: decoded['user_status'] ?? decoded['User_Status'],
        // applicationID: decoded['applicationID'] ?? decoded['application_id'],
        transactionNumber: decoded['transaction_number'] ?? decoded['transactionNumber'] ?? decoded['transaction_id'] ?? decoded['application_number'],
        // version: decoded['version'] ?? decoded['Version'],
        // versionPopActive: decoded['version_pop_active'] ?? decoded['versionPopActive'],
        // maintenance: decoded['maintenance'],
        value: decoded['value'] ?? decoded['value'],
        status: decoded['status'] ?? decoded['Status'] ?? decoded['success'],
        // biometrics: decoded['biometrics'] ?? decoded['Biometrics'],
        result: decoded['data'] ?? (decoded['Data'] ?? decoded['config'] ?? decoded['contents']),
        // code: decoded['result'] == null ? '0' : decoded['result'].toString(),
        dateRequested: decoded['DateTime'] ?? decoded['date_requested'],
      );
    } else if (response.statusCode >= 200 && response.statusCode < 300) {
      return APIResult(message:'Unauthorized', result: null, status: false);
    } else if (response.statusCode >= 300 && response.statusCode < 400) {
      return APIResult(message:'Unauthorized', result: null, status: false);
    } else if (response.statusCode >= 400 && response.statusCode < 500) {
      return APIResult(message:'Server error', result: null, status: false);
    } else if (response.statusCode >= 500 && response.statusCode < 600) {
      return APIResult(message:'Server error', result: null, status: false);
    } else {
      return APIResult(message:'No internet connection', result: null);
    }
  }

}