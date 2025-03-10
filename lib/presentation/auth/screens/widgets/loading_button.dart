import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:xylo/core/constants.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 10),
            elevation: 0.2,
            backgroundColor: const Color.fromARGB(255, 98, 98, 98),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
        onPressed: () {},
        child: LoadingAnimationWidget.threeArchedCircle(
          color: loadingColor,
          size: 20,
        ),
      ),
    );
  }
}
