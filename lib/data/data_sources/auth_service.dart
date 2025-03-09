import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  SupabaseClient supabaseClient;
  AuthService({required this.supabaseClient});

  Future<AuthResponse> signIn(String email, String password) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<AuthResponse> signUp(String email, String password) async {
    try {
      final response =
          await supabaseClient.auth.signUp(email: email, password: password);

      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
