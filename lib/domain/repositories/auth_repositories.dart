import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce/common/error/failure.dart';
import 'package:flutter_ecommerce/domain/entities/login.dart';
import 'package:flutter_ecommerce/domain/entities/user.dart';

abstract class AuthRepositories {
  Future<Either<Failure, User>> postLogin(String url, LoginEntity login);
}
