import 'package:equatable/equatable.dart';

class Register extends Equatable {
  final String name;
  final String email;
  final String handphone;
  final String password;
  final String passwordConfirmation;

  const Register(
      {required this.name,
      required this.email,
      required this.handphone,
      required this.password,
      required this.passwordConfirmation});

  @override
  List<Object> get props =>
      [name, email, handphone, password, passwordConfirmation];
}
