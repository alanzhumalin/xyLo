import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xylo/core/constants.dart';
import 'package:xylo/logic/auth/auth_bloc.dart';
import 'package:xylo/logic/auth/auth_event.dart';
import 'package:xylo/logic/auth/auth_state.dart';
import 'package:xylo/presentation/auth/screens/widgets/custom_button.dart';
import 'package:xylo/presentation/auth/screens/widgets/loading_button.dart';
import 'package:xylo/presentation/auth/screens/widgets/text_form.dart';
import 'package:xylo/presentation/navigation_bar/nav_bar.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();
  final _majorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: padding,
          child: Stack(
            children: [
              Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Start with creating new account',
                        style: textStyle.copyWith(fontSize: 22),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextForm(
                        controller: _emailController,
                        hinttext: 'Email',
                        validator: (value) {
                          if (value == null || !value.contains('@sdu.edu.kz')) {
                            return 'Pls write your uni email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 9),
                      TextForm(
                        controller: _usernameController,
                        hinttext: 'Username',
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length < 3) {
                            return 'Username cannot be empty, at least 3 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 9),
                      TextForm(
                        controller: _majorController,
                        hinttext: 'Major',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Major cannot be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 9),
                      TextForm(
                        controller: _passwordController,
                        hinttext: 'Password',
                        validator: (value) {
                          if (value == null || value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      BlocConsumer<AuthBloc, AuthState>(
                          listener: (context, state) {
                        if (state is AuthError) {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(state.error),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('OK'))
                                  ],
                                );
                              });
                          if (state is AuthSuccessful) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NavBar()),
                                (Route<dynamic> route) => false);
                          }
                        }
                      }, builder: (context, state) {
                        if (state is AuthLoading) {
                          return LoadingButton();
                        }
                        return CustomButton(
                            function: () {
                              if (_key.currentState!.validate()) {
                                context.read<AuthBloc>().add(RegisterRequested(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                    major: _majorController.text,
                                    username: _usernameController.text.trim()));
                              }
                            },
                            title: 'Create');
                      })
                    ],
                  )),
              Positioned(
                  left: -5,
                  top: 50,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new)))
            ],
          ),
        ),
      ),
    );
  }
}
