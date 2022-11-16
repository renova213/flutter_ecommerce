import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_ecommerce/common/config/network/base_url.dart';
import 'package:flutter_ecommerce/domain/entities/login.dart';
import 'package:flutter_ecommerce/domain/entities/user.dart';
import 'package:flutter_ecommerce/domain/usecases/auth/post_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final PostLogin postLogin;
  LoginBloc({required this.postLogin}) : super(LoginInitial()) {
    on<Login>(
      (event, emit) async {
        emit(LoginLoading());

        final failureOrUser = await postLogin(loginUrl, event.login);

        failureOrUser.fold(
          (failure) => emit(
            LoginFailure(message: failure.message),
          ),
          (user) => emit(
            LoginLoadedUser(user: user),
          ),
        );
      },
    );

    on<Logout>(
      (event, emit) async {
        if (state is LoginLoadedUser) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.remove('token');
        }

        emit(UserLogout());
      },
    );

    on<CheckLoginStatus>(
      (event, emit) async {
        SharedPreferences pref = await SharedPreferences.getInstance();

        String? token = pref.getString('token');

        if (token != null) {
          emit(UserLogout());
        } else {
          emit(UserLogin());
        }
      },
    );
  }
}
