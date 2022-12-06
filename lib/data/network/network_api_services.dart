import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../config/config.dart';
import '../../models/login_model.dart';
import 'base_api_service.dart';

class NetworkApiServices implements BaseApiServices {
  @override
  Future<dynamic> postLogin(String url, LoginModel data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response = await http.post(
        Uri.parse('$baseUrl$url'),
        body: data.toJson(),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
      );
      if (response.statusCode == 200) {
        prefs.setString(
          'token',
          json.decode(response.body)['data']['token'],
        );
        prefs.setInt(
            'userid', json.decode(response.body)['data']['user']['id']);
        prefs.setString(
            'phone', json.decode(response.body)['data']['user']['handphone']);
        prefs.setString(
            'email', json.decode(response.body)['data']['user']['email']);
        prefs.setString(
            'name', json.decode(response.body)['data']['user']['name']);
        return returnResponse(response);
      }
      return returnResponse(response);
    } on SocketException {
      throw 'No Internet Connection';
    }
  }

  @override
  Future<dynamic> postRequest(String url, data) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();
    try {
      final response = await http.post(
        Uri.parse('$baseUrl$url'),
        body: data is Map ? data : data.toJson(),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      return returnResponse(response);
    } on SocketException {
      throw 'No Internet Connection';
    }
  }

  @override
  Future<dynamic> getRequest(String url) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    try {
      final response = await http.get(
        Uri.parse('$baseUrl$url'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return returnResponse(response);
    } on SocketException {
      throw 'No Internet Connection';
    }
  }

  @override
  Future deleteRequest(String url) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    try {
      final response = await http.delete(
        Uri.parse('$baseUrl$url'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      return returnResponse(response);
    } on SocketException {
      throw 'No Internet Connection';
    }
  }

  @override
  Future postMulipart(String url, List<File>? files, Map<String, String> body,
      String imageKey) async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token').toString();

    try {
      var request = http.MultipartRequest("POST", Uri.parse('$baseUrl$url'));

      request.headers.addAll({"Authorization": "Bearer $token"});

      request.fields.addAll(body);

      if (files != null) {
        for (var file in files) {
          request.files
              .add(await http.MultipartFile.fromPath(imageKey, file.path));
        }
      }

      var sendRequest = await request.send();
      var response = await http.Response.fromStream(sendRequest);
      return returnResponse(response);
    } on SocketException {
      throw 'No Internet Connection';
    }
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw json.decode(response.body)['info'];
      case 401:
        throw json.decode(response.body)['info'];
      case 404:
        throw json.decode(response.body)['info'];
      case 500:
        throw json.decode(response.body)['info'];
      default:
        throw "Error accourded while communicating with server with status code ${response.statusCode}";
    }
  }
}
