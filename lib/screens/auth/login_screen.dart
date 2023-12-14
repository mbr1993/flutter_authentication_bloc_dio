import 'package:flutter/material.dart';
import 'package:flutter_authentication_bloc/repository/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/login_bloc/login_bloc.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;

  const LoginScreen({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => LoginBloc(
          userRepository: userRepository,
          authBloc: BlocProvider.of<AuthBloc>(context),
        ),
        child: LoginForm(userRepository: userRepository),
      ),
    );
  }
}
