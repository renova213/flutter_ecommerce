part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class Login extends LoginEvent {
  final LoginEntity login;

  const Login({required this.login});

  @override
  List<Object> get props => [login];
}

class Logout extends LoginEvent {}

class CheckLoginStatus extends LoginEvent {}
