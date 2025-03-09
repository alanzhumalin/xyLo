import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:xylo/core/di.dart';
import 'package:xylo/core/simple_bloc_observer.dart';
import 'package:xylo/core/theme.dart';
import 'package:xylo/logic/auth/auth_bloc.dart';
import 'package:xylo/presentation/auth/screens/auth_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  Bloc.observer = SimpleBlocObserver();

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (context) => AuthBloc(
            getCurrentUserData: getCurrentUserData,
            getUserData: getUserData,
            userExistUsecase: userExistUsecase,
            registerUsecase: registerUsecase,
            saveUserTodb: saveUserTodb,
            signInUsecase: signInUsecase,
            signOutUsecase: signOutUsecase))
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: AuthCheck(),
    );
  }
}
