import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xylo/core/theme.dart';
import 'package:xylo/logic/auth/auth_bloc.dart';
import 'package:xylo/logic/auth/auth_state.dart';
import 'package:xylo/logic/profile/profile_bloc.dart';
import 'package:xylo/logic/profile/profile_event.dart';
import 'package:xylo/presentation/auth/screens/auth_check.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessful) {
          context
              .read<ProfileBloc>()
              .add(LoadUserProfile(id: state.userModel.id));
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: darkTheme,
        home: AuthCheck(),
      ),
    );
  }
}
