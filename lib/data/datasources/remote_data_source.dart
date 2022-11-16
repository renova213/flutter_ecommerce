import 'dart:convert';

import 'package:flutter_ecommerce/data/datasources/local_data_source.dart';
import 'package:flutter_ecommerce/data/models/login_model.dart';
import 'package:flutter_ecommerce/data/models/user_model.dart';
import 'package:flutter_ecommerce/domain/entities/user.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<User> postLogin(String url, LoginModel login);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  final LocalDataSource localDataSource;

  RemoteDataSourceImpl({required this.client, required this.localDataSource});

  @override
  Future<UserModel> postLogin(String url, LoginModel login) async {
    final response = await client.post(
      Uri.parse(url),
      body: login.toJson(),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
    );
    if (response.statusCode == 200) {
      localDataSource.setToken(
        json.decode(response.body)['data']['token'],
      );
      return UserModel.fromJson(
        json.decode(response.body),
      );
    } else {
      throw json.decode(response.body)['info'];
    }
  }
}
