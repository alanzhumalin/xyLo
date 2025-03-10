import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

final Color buttonColor = Colors.blue;

final Color loadingColor = const Color.fromARGB(255, 93, 33, 243);

final TextStyle textStyle =
    TextStyle(fontWeight: FontWeight.bold, fontSize: 21, color: Colors.white);

final EdgeInsetsGeometry padding = EdgeInsets.symmetric(horizontal: 15);

final loading = LoadingAnimationWidget.threeArchedCircle(
  color: loadingColor,
  size: 20,
);
