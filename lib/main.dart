import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/presentation/auth/business/bloc/auth_bloc/auth_bloc.dart';
import 'features/presentation/auth/data/repository/repositories.dart';
import 'features/presentation/auth/presentation/login_screen.dart';
import 'features/presentation/main/main_screen.dart';

void main() {
  final userRepository = UserRepository();
  runApp(
    BlocProvider<AuthBloc>(
      create: (BuildContext context) {
        return AuthBloc(userRepository: userRepository)..add(AppStarted());
      },
      child: MyApp(userRepository: userRepository),
    ),
  );
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp({super.key, required this.userRepository});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          switch (state) {
            case AuthAuthenticated():
              return const MainScreen();
            case AuthUnauthenticated():
              return LoginScreen(userRepository: userRepository);
            default:
              return Scaffold(
                body: Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 25.0,
                        width: 25.0,
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent), strokeWidth: 4.0),
                      )
                    ],
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
