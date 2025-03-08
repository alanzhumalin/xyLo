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

class LogOut extends AuthEvent {}
