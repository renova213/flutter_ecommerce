import 'package:flutter_ecommerce/data/models/register_model.dart';
import 'package:flutter_ecommerce/domain/entities/register.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const testRegisterModel = RegisterModel(
      name: 'name',
      email: 'email',
      handphone: 'handphone',
      password: 'password',
      passwordConfirmation: 'passwordConfirmation');

  test('should be a subclass of Register entity', () {
    expect(testRegisterModel, isA<Register>());
  });

  group('toJson', () {
    test('object should be convert to Map', () {
      final jsonMap = {
        'name': 'name',
        'email': 'email',
        'handphone': 'handphone',
        'password': 'password',
        'password_confirmation': 'passwordConfirmation'
      };

      final result = testRegisterModel.toJson();
      expect(result, equals(jsonMap));
    });
  });
}
