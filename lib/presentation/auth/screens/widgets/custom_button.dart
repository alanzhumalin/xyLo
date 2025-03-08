import 'package:flutter/material.dart';
import 'package:xylo/core/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.function, required this.title});
  final String title;
  final VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0.2,
            backgroundColor: Colors.blueAccent,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        onPressed: function,
        child: Text(
          title,
          style: textStyle,
        ));
  }
}
