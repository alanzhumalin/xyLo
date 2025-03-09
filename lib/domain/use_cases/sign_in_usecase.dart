import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:xylo/domain/repositories/auth_repository.dart';

class SignInUsecase {
  final AuthRepository authRepository;
  SignInUsecase({required this.authRepository});

  Future<AuthResponse> call(String email, String password) async {
    return await authRepository.signIn(email, password);
  }
}
