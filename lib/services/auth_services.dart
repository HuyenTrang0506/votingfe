import 'dart:convert';
import 'dart:io';

import 'package:flutter_application/models/user.dart';
import 'package:flutter_application/services/api_status.dart';
import 'package:flutter_application/utils/constant.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Future<Object> signUp(UserModel user) async {
    try {
      var url = Uri.parse(SIGN_UP_URL);
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(user.toJson()),
      );
      if (response.statusCode == 201) {
        return Success(response: UserModel.fromJson(jsonDecode(response.body)));
      } else {
        return Failure(
            code: USER_INVALID_RESPONSE, errorResponse: 'Invalid response');
      }
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }

  static Future<Object> signIn(UserModel user) async {
    try {
      var url = Uri.parse(SIGN_IN_URL);
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(user.toJson()),
      );
      print(user.email);
      if (response.statusCode == 200) {
        print("thanh cong r ne");
        print(response.body);
        return Success(response: UserModel.fromJson(jsonDecode(response.body)));
      } else {
        return Failure(
            code: USER_INVALID_RESPONSE, errorResponse: 'Invalid response');
      }
    } on HttpException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on SocketException {
      return Failure(
          code: NO_INTERNET, errorResponse: 'No Internet Connection');
    } on FormatException {
      return Failure(code: INVALID_FORMAT, errorResponse: 'Invalid Format');
    } catch (e) {
      return Failure(code: UNKNOWN_ERROR, errorResponse: 'Unknown Error');
    }
  }
}
