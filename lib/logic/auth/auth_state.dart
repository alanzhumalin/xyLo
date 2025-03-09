import 'package:xylo/data/models/user_model.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccessful extends AuthState {
  final UserModel userModel;
  AuthSuccessful({required this.userModel});
}

class AuthError extends AuthState {
  final String error;
  AuthError({required this.error});
}
