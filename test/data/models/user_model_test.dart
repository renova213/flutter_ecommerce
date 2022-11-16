import 'dart:convert';

import 'package:flutter_ecommerce/data/models/user_model.dart';
import 'package:flutter_ecommerce/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const testProductModel = UserModel(
    userData: UserDataModel(
      userDetail: UserDetailModel(
          id: 0,
          name: 'name',
          email: 'email',
          handphone: 'handphone',
          role: 'role'),
    ),
  );

  test('should be a subclass of User entity', () {
    expect(testProductModel, isA<User>());
  });

  group('fromJson', () {
    test('should return valid model UserModel from json', () {
      final jsonMap = json.decode(
        fixture('user.json'),
      );

      final result = UserModel.fromJson(jsonMap);
      expect(result, testProductModel);
    });
  });
}
