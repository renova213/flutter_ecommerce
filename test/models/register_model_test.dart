import 'package:flutter_ecommerce/models/register_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  RegisterModel testRegisterModel = RegisterModel(
      name: 'name',
      email: 'email',
      handphone: 'handphone',
      password: 'password',
      passwordConfirmation: 'passwordConfirmation');

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
