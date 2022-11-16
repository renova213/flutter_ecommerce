import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/domain/entities/login.dart';
import 'package:flutter_ecommerce/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:flutter_ecommerce/presentation/pages/home/home_page.dart';
import 'package:flutter_ecommerce/presentation/pages/widgets/button_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginLoadedUser) {
              Fluttertoast.showToast(msg: "Berhasil Login");
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            }

            if (state is LoginFailure) {
              Fluttertoast.showToast(msg: state.message);
            }
          },
          child: ButtonWidget(
              buttonText: "Login",
              height: 40,
              width: 150,
              onpressed: () async {
                context.read<LoginBloc>().add(
                      const Login(
                        login: LoginEntity(
                            email: 'farhan@test.com', password: 'password'),
                      ),
                    );
              },
              radius: 10),
        ),
      ),
    );
  }
}
