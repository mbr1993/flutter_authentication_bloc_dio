import 'package:flutter/material.dart';
import 'package:flutter_authentication_bloc/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_authentication_bloc/repository/repositories.dart';
import 'package:flutter_authentication_bloc/screens/auth/login_screen.dart';
import 'package:flutter_authentication_bloc/screens/main/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      locale: const Locale('id', 'ID'),
      theme: ThemeData(fontFamily: 'Rubik', primarySwatch: Colors.blueGrey),
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            return const MainScreen();
          } else if (state is AuthUnauthenticated) {
            return LoginScreen(userRepository: userRepository);
          }
          if (state is AuthLoading) {
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
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
                        strokeWidth: 4.0,
                      ),
                    )
                  ],
                ),
              ),
            );
          }
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
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
                      strokeWidth: 4.0,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
