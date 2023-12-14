import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_authentication_bloc/repository/repositories.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc/auth_bloc.dart';
import '../../bloc/login_bloc/login_bloc.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository userRepository;

  LoginScreen({super.key, required this.userRepository});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => LoginBloc(userRepository: userRepository, authBloc: BlocProvider.of<AuthBloc>(context)),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error), backgroundColor: Colors.red),
              );
            }
          },
          child: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Form(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 200,
                        padding: const EdgeInsets.only(top: 40, bottom: 20),
                        child: const Column(
                          children: [
                            Text(
                              "AUTH WITH REST",
                              style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold, fontSize: 24.0),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              "Login app using BLOC pattern and REST API",
                              style: TextStyle(fontSize: 10.0, color: Colors.black38),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        style: const TextStyle(fontSize: 14.0, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(EvaIcons.emailOutline, color: Colors.black26),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.purpleAccent),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
                          labelText: "E-Mail",
                          hintStyle: const TextStyle(fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.w500),
                          labelStyle: const TextStyle(fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                        autocorrect: false,
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        style: const TextStyle(fontSize: 14.0, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                        controller: _passwordController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          prefixIcon: const Icon(EvaIcons.lockOutline, color: Colors.black26),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.black12),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.grey),
                              borderRadius: BorderRadius.circular(30.0)),
                          contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
                          labelText: "Password",
                          hintStyle: const TextStyle(fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.w500),
                          labelStyle: const TextStyle(fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                        autocorrect: false,
                        obscureText: true,
                      ),
                      const SizedBox(height: 20.0),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          child:
                              const Text("Forget password?", style: TextStyle(color: Colors.black45, fontSize: 12.0)),
                          onTap: () {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(
                              height: 45,
                              child: state is LoginLoading
                                  ? const Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                width: 25,
                                                height: 25,
                                                child: CupertinoActivityIndicator(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        BlocProvider.of<LoginBloc>(context).add(
                                          LoginButtonPressed(
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.purpleAccent,
                                          disabledBackgroundColor: Colors.purpleAccent,
                                          disabledForegroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(30.0),
                                          )),
                                      child: const Text(
                                        'Login',
                                        style:
                                            TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
