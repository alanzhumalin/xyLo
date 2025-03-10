import 'package:flutter/material.dart';
import 'package:xylo/core/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xylo/logic/auth/auth_bloc.dart';
import 'package:xylo/logic/auth/auth_event.dart';
import 'package:xylo/logic/auth/auth_state.dart';
import 'package:xylo/presentation/auth/screens/register.dart';
import 'package:xylo/presentation/auth/screens/widgets/custom_button.dart';
import 'package:xylo/presentation/auth/screens/widgets/loading_button.dart';
import 'package:xylo/presentation/auth/screens/widgets/text_form.dart';
import 'package:xylo/presentation/navigation_bar/nav_bar.dart';
import 'package:xylo/presentation/post/screens/lenta.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding: padding,
          child: Form(
              key: _key,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Ohh, you find us. Maybe join to us???',
                    style: textStyle,
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
                  SizedBox(
                    height: 8,
                  ),
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
                  BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
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
                    }
                    if (state is AuthSuccessful) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => NavBar()),
                          (Route<dynamic> route) => false);
                    }
                  }, builder: (context, state) {
                    if (state is AuthLoading) {
                      return LoadingButton();
                    }
                    return CustomButton(
                        function: () {
                          if (_key.currentState!.validate()) {
                            context.read<AuthBloc>().add(LoginRequested(
                                email: _emailController.text,
                                password: _passwordController.text));
                          }
                        },
                        title: 'Sign in');
                  }),
                  CustomButton(
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      title: 'Create new account')
                ],
              )),
        ),
      ),
    );
  }
}
