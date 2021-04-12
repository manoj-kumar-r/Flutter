import 'dart:convert';

import 'package:bajajdt/com/bajaj/dnt/models/ApiModel.dart';
import 'package:http/http.dart' as http;

import 'AppConstants.dart';

class CustomApi {
  static Future<MasterResponse> fetchLanguage() async {
    final response = await http.post(
        Uri.parse(AppConstants.baseUrl + AppConstants.languagePoint),
        headers: {"Content-Type": "application/x-www-form-urlencoded"});
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var responseBody = response.body;
      print("responseBody:$responseBody");
      return MasterResponse.fromJson(jsonDecode(responseBody));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      var masterResponse = MasterResponse();
      masterResponse.responseStatus = "false";
      masterResponse.errorMessage = response.reasonPhrase;
      return masterResponse;
    }
  }

  static Future<MasterResponse> loginMethod(
      String userName, String password) async {
    final response = await http.post(
      Uri.parse(AppConstants.baseUrl + AppConstants.loginPoint),
      body: "UserName=$userName&Password=$password",
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
    );
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return MasterResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      var masterResponse = MasterResponse();
      masterResponse.responseStatus = "false";
      masterResponse.errorMessage = response.reasonPhrase;
      return masterResponse;
    }
  }
}
