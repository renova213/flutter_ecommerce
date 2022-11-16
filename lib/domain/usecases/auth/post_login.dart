import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce/common/error/failure.dart';
import 'package:flutter_ecommerce/domain/entities/login.dart';
import 'package:flutter_ecommerce/domain/entities/user.dart';
import 'package:flutter_ecommerce/domain/repositories/auth_repositories.dart';

class PostLogin {
  final AuthRepositories authRepositories;

  PostLogin({required this.authRepositories});

  Future<Either<Failure, User>> call(String url, LoginEntity login) async {
    Either<Failure, User> user = await authRepositories.postLogin(url, login);
    return user;
  }
}
