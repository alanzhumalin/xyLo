import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:xylo/core/constants.dart';
import 'package:xylo/presentation/auth/screens/login.dart';
import 'package:xylo/presentation/post/screens/lenta.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  SupabaseClient supabaseClient = Supabase.instance.client;

  Future<void> authCheck() async {
    final session = supabaseClient.auth.currentSession;
    Widget nextScreen = session != null ? Lenta() : Login();

    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => nextScreen,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var tween = Tween<double>(begin: 0.0, end: 1.0)
                .chain(CurveTween(curve: Curves.easeInOut));

            return ScaleTransition(
              scale: animation.drive(tween),
              child: child,
            );
          },
        ),
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(authCheck);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.threeArchedCircle(
          color: loadingColor,
          size: 30,
        ),
      ),
    );
  }
}
