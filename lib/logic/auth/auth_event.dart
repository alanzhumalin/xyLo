import 'package:xylo/data/models/user_model.dart';

sealed class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested({required this.email, required this.password});
}

class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String username;
  final String major;

  RegisterRequested(
      {required this.email,
      required this.password,
      required this.major,
      required this.username});
}

class AppStarted extends AuthEvent {
  UserModel? userModel;
  AppStarted({required this.userModel});
}

class LogOut extends AuthEvent {}
