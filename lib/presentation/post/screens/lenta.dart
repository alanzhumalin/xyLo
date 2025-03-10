import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:xylo/core/constants.dart';
import 'package:xylo/logic/auth/auth_bloc.dart';
import 'package:xylo/logic/auth/auth_event.dart';
import 'package:xylo/logic/auth/auth_state.dart';
import 'package:xylo/presentation/auth/screens/login.dart';

class Lenta extends StatelessWidget {
  const Lenta({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        actions: [
          BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
            if (state is AuthInitial) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                  (Route<dynamic> route) => false);
            }
          }, builder: (context, state) {
            return IconButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LogOut());
                },
                icon: Icon(Icons.exit_to_app));
          })
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              if (state is AuthError) {
                return Center(child: Text('Ошибка'));
              }
              if (state is AuthLoading) {
                return Center(child: loading);
              }
              if (state is AuthSuccessful) {
                return Center(child: Text(state.userModel.username));
              }
              return Center(
                child: Text('Error'),
              );
            }),
          )
        ],
      ),
    );
  }
}
