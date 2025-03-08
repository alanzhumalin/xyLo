import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:xylo/core/theme.dart';
import 'package:xylo/presentation/auth/screens/auth_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://xyzcompany.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR2amNycWxmdWN0eW1xdmFkbnhvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDE0MjE3MjIsImV4cCI6MjA1Njk5NzcyMn0.rpwM1sph7KRC0fX9oh3Xg26pRmA1A5nga1Yp8vZsaYI',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: darkTheme,
      home: AuthCheck(),
    );
  }
}
