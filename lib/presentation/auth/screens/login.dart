import 'package:flutter/material.dart';
import 'package:xylo/core/constants.dart';

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
      body: Form(
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
              TextFormField(
                controller: _emailController,
                decoration:
                    InputDecoration(fillColor: C, border: OutlineInputBorder()),
              )
            ],
          )),
    );
  }
}
