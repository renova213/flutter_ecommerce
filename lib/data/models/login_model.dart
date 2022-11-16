import 'package:flutter_ecommerce/domain/entities/login.dart';

class LoginModel extends LoginEntity {
  const LoginModel({required super.email, required super.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};

  factory LoginModel.fromEntity(LoginEntity login) =>
      LoginModel(email: login.email, password: login.password);
}
