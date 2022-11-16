import 'package:equatable/equatable.dart';

class User extends Equatable {
  final UserData userData;

  const User({required this.userData});

  @override
  List<Object> get props => [userData];
}

class UserData extends Equatable {
  final UserDetail userDetail;

  const UserData({required this.userDetail});

  @override
  List<Object> get props => [userDetail];
}

class UserDetail extends Equatable {
  final int id;
  final String name;
  final String email;
  final String handphone;
  final String role;

  const UserDetail(
      {required this.id,
      required this.name,
      required this.email,
      required this.handphone,
      required this.role});

  @override
  List<Object> get props => [id, name, email, handphone, role];
}
