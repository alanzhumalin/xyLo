import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  const TextForm(
      {super.key,
      required this.validator,
      required this.controller,
      required this.hinttext});
  final TextEditingController controller;
  final String hinttext;
  final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        showCursor: true,
        cursorColor: Colors.blue,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: hinttext,
            fillColor: const Color.fromARGB(255, 74, 74, 74),
            filled: true,
            hintStyle:
                TextStyle(color: const Color.fromARGB(255, 228, 228, 228)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5)),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5))),
        validator: validator);
  }
}
