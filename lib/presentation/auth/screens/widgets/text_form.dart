import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  const TextForm({super.key, required this.controller, required this.hinttext});
  final TextEditingController controller;
  final String hinttext;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hinttext,
          fillColor: Colors.blueGrey,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
      validator: (value) {
        if (hinttext == 'Email') {
          if (value == null || !value.contains('@sdu.edu.kz')) {
            return 'Pls write your uni email';
          }
          return null;
        } else {
          if (value == null || value.length <= 7) {
            return 'Password must be at least 8 characters';
          }
          return null;
        }
      },
    );
  }
}
