import 'package:flutter/material.dart';
import 'package:xylo/core/constants.dart';
import 'package:xylo/presentation/auth/screens/widgets/custom_button.dart';
import 'package:xylo/presentation/auth/screens/widgets/text_form.dart';

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
                      CustomButton(
                          function: () {
                            if (_key.currentState!.validate()) {
                              print('object');
                            }
                          },
                          title: 'Create')
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
