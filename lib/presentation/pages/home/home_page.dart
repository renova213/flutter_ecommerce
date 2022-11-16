import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/presentation/blocs/login_bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/presentation/pages/login/login_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            context.read<LoginBloc>().add(Logout());

            Fluttertoast.showToast(msg: 'Berhasil Logout');

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
                (route) => false);
          },
          child: const Text("Logout"),
        ),
      ),
    );
  }
}
