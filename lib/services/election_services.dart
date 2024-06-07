import 'dart:io';
import 'package:flutter_application/models/election.dart';
import 'package:flutter_application/services/api_status.dart';
import 'package:flutter_application/utils/constant.dart';
import 'package:http/http.dart' as http;

class ElectionServices {
  static Future<Object> getElections(String accessToken) async {
    try {
      var url = Uri.parse(ELECTION_LIST);
   
      final response = await http.get(url,headers: 
      {"Content-Type": "application/json",
        "Authorization": "Bearer $accessToken",
      });
      print(response.body);
    
      if (response.statusCode == 200) {
        return Success(response: electionListModelFromJson(response.body));
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