import 'package:flutter_ecommerce/data/datasources/local_data_source.dart';
import 'package:flutter_ecommerce/data/datasources/remote_data_source.dart';
import 'package:flutter_ecommerce/data/repositories/auth_repositories_impl.dart';
import 'package:flutter_ecommerce/domain/repositories/auth_repositories.dart';
import 'package:flutter_ecommerce/domain/usecases/auth/post_login.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'presentation/blocs/login_bloc/login_bloc.dart';

final sl = GetIt.instance;

Future<void> setUp() async {
  //data
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      client: sl(),
      localDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(sharedPreferences: sl()),
  );

  //domain
  sl.registerLazySingleton<AuthRepositories>(
    () => AuthRepositoriesImpl(
      remoteDataSource: sl(),
    ),
  );

  //usecase
  sl.registerLazySingleton<PostLogin>(
    () => PostLogin(
      authRepositories: sl(),
    ),
  );

  //bloc
  sl.registerFactory<LoginBloc>(
    () => LoginBloc(
      postLogin: sl(),
    ),
  );

  //external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}
