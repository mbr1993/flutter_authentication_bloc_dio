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
                              style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 24.0),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              "Login app using BLOC pattern and REST API",
                              style: TextStyle(fontSize: 10.0, color: Colors.black38),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        style: const TextStyle(fontSize: 14.0, color: Colors.deepPurple),
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email_outlined, color: Colors.black26),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurpleAccent)),
                          contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                          labelText: "E-Mail",
                          hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.w500),
                          labelStyle: TextStyle(fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                        autocorrect: false,
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        style: const TextStyle(fontSize: 14.0, color: Colors.deepPurple),
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.black26),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black12)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurpleAccent)),
                          contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
                          labelText: "Password",
                          hintStyle: TextStyle(fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.w500),
                          labelStyle: TextStyle(fontSize: 12.0, color: Colors.grey, fontWeight: FontWeight.w500),
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
                                  ? const CupertinoActivityIndicator()
                                  : ElevatedButton(
                                      onPressed: () {
                                        BlocProvider.of<LoginBloc>(context).add(
                                          LoginButtonPressed(
                                            email: _emailController.text,
                                            password: _passwordController.text,
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
                                      child: const Text('Login', style: TextStyle(color: Colors.white)),
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
