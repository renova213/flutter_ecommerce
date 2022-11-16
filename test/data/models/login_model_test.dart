import 'package:flutter_ecommerce/data/models/login_model.dart';
import 'package:flutter_ecommerce/domain/entities/login.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testLoginModel = LoginModel(email: 'email', password: 'password');

  test('should be a subclass of Login entity', () {
    expect(testLoginModel, isA<LoginEntity>());
  });

  group('toJson', () {
    test('object should be convert to Map', () {
      final jsonMap = {'email': 'email', 'password': 'password'};

      final result = testLoginModel.toJson();
      expect(result, equals(jsonMap));
    });
  });
}
