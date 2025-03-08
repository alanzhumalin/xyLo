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
    if (session != null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Lenta()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authCheck();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
          color: loadingColor, size: 30),
    );
  }
}
