import 'package:flutter_ecommerce/domain/entities/register.dart';

class RegisterModel extends Register {
  const RegisterModel(
      {required super.name,
      required super.email,
      required super.handphone,
      required super.password,
      required super.passwordConfirmation});

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'handphone': handphone,
        'password': password,
        'password_confirmation': passwordConfirmation
      };
}
