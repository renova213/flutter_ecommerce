import 'package:flutter_ecommerce/data/datasources/remote_data_source.dart';
import 'package:flutter_ecommerce/data/models/login_model.dart';
import 'package:flutter_ecommerce/domain/entities/login.dart';
import 'package:flutter_ecommerce/domain/entities/user.dart';
import 'package:flutter_ecommerce/common/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_ecommerce/domain/repositories/auth_repositories.dart';

class AuthRepositoriesImpl implements AuthRepositories {
  final RemoteDataSource remoteDataSource;

  AuthRepositoriesImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, User>> postLogin(String url, LoginEntity login) async {
    try {
      final user = await remoteDataSource.postLogin(
        url,
        LoginModel.fromEntity(login),
      );
      return Right(user);
    } catch (e) {
      return Left(
        ServerFailure(message: e.toString()),
      );
    }
  }
}
