import 'package:flutter/material.dart';
import 'package:xylo/core/constants.dart';
import 'package:xylo/presentation/auth/screens/widgets/custom_button.dart';
import 'package:xylo/presentation/auth/screens/widgets/text_form.dart';

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
    return Scaffold(
      body: Padding(
        padding: padding,
        child: Form(
            key: _key,
            child: Column(
              children: [
                Text(
                  'Ohh, you find us. Maaybe join to us???',
                  style: textStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                TextForm(controller: _emailController, hinttext: 'Email'),
                SizedBox(
                  height: 5,
                ),
                TextForm(controller: _passwordController, hinttext: 'Password'),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                        child: CustomButton(function: () {}, title: 'Sign in')),
                    Expanded(
                        child: CustomButton(function: () {}, title: 'Sign up')),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
