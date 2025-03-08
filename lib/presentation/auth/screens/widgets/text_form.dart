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
    );
  }
}
