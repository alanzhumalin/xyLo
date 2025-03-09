import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:xylo/data/data_sources/auth_service.dart';
import 'package:xylo/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;

  AuthRepositoryImpl({required this.authService});

  @override
  Future<AuthResponse> signIn(String email, String password) async {
    return await authService.signIn(email, password);
  }

  @override
  Future<AuthResponse> signUp(String email, String password) async {
    return await authService.signUp(email, password);
  }

  @override
  Future<void> signOut() async {
    return await authService.signOut();
  }
}
