import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalDataSource {
  Future<void> setToken(String token);
  Future<String> getToken();
}

class LocalDataSourceImpl implements LocalDataSource {
  final SharedPreferences sharedPreferences;

  LocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<void> setToken(String token) async {
    sharedPreferences.setString('token', token);
  }

  @override
  Future<String> getToken() async {
    final String token = sharedPreferences.getString('token')!;
    return token;
  }
}
