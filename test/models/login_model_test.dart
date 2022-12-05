import 'package:flutter_ecommerce/models/login_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  LoginModel testLoginModel = LoginModel(email: 'email', password: 'password');

  group('toJson', () {
    test('object should be convert to Map', () {
      final jsonMap = {'email': 'email', 'password': 'password'};

      final result = testLoginModel.toJson();
      expect(result, equals(jsonMap));
    });
  });
}
