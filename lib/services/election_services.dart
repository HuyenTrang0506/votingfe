import 'dart:convert';
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
  } // In ElectionServices.dart

  static Future<Object> saveElection(
      String accessToken, ElectionModel election) async {
    try {
      var url = Uri.parse(ELECTION_LIST); // Replace with your API endpoint

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
        body: jsonEncode(election.toJson()),
      );
      
      if (response.statusCode == 200) {
          print(response.statusCode);
        return Success(response: ElectionModel.fromJson(jsonDecode(response.body)));
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
  static Future<Object> deleteElection(
      String accessToken, String electionId) async {
    try {
      var url = Uri.parse(ELECTION_LIST + "/$electionId");
      final response = await http.delete(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        },
      );
      if (response.statusCode == 200) {
        return Success(response: "Election deleted");
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