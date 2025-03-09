import 'package:flutter/material.dart';
import 'package:xylo/core/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.function, required this.title});
  final String title;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: 10),
              elevation: 0.2,
              backgroundColor: title == 'Sign in'
                  ? const Color.fromARGB(255, 44, 5, 188)
                  : const Color.fromARGB(255, 182, 20, 252),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5))),
          onPressed: function,
          child: Text(
            title,
            style: textStyle.copyWith(fontSize: 15),
          )),
    );
  }
}
