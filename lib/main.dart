import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce/injection.dart';
import 'package:flutter_ecommerce/presentation/pages/home/home_page.dart';
import 'package:flutter_ecommerce/presentation/pages/login/login_page.dart';

import 'presentation/blocs/login_bloc/login_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (_) => sl<LoginBloc>()..add(CheckLoginStatus()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is UserLogin) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                  (route) => false);
            }

            if (state is UserLogin) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                  (route) => false);
            }
          },
          child: const LoginPage(),
        ),
      ),
    );
  }
}
