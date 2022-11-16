part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoadedUser extends LoginState {
  final User user;

  const LoginLoadedUser({required this.user});

  @override
  List<Object> get props => [user];
}

class LoginFailure extends LoginState {
  final String message;

  const LoginFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class UserLogout extends LoginState {}

class UserLogin extends LoginState {}
