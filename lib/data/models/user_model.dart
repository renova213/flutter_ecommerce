import 'package:flutter_ecommerce/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required super.userData});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userData: UserDataModel.fromJson(json['data']),
      );
}

class UserDataModel extends UserData {
  const UserDataModel({required super.userDetail});

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        userDetail: UserDetailModel.fromJson(json['user']),
      );
}

class UserDetailModel extends UserDetail {
  const UserDetailModel(
      {required super.id,
      required super.name,
      required super.email,
      required super.handphone,
      required super.role});

  factory UserDetailModel.fromJson(Map<String, dynamic> json) =>
      UserDetailModel(
          id: json['id'] ?? 0,
          name: json['name'] ?? 'null',
          email: json['email'] ?? 'null',
          handphone: json['handphone'] ?? 'null',
          role: json['role'] ?? 'null');
}
