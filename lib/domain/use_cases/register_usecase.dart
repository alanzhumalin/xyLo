import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:xylo/domain/repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository authRepository;
  RegisterUsecase({required this.authRepository});

  Future<AuthResponse> call(String email, String password) async {
    return await authRepository.signUp(email, password);
  }
}
