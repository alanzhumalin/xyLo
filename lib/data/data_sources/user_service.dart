import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:xylo/data/models/user_model.dart';

class UserService {
  SupabaseClient supabaseClient;

  UserService({required this.supabaseClient});

  Future<UserModel> getCurrentUserData() async {
    try {
      final cred = supabaseClient.auth.currentUser;

      if (cred == null) {
        return throw Exception('No user logged in');
      }

      final user = await supabaseClient
          .from('users')
          .select()
          .eq('id', cred.id)
          .maybeSingle();

      if (user == null) {
        throw Exception('This user does not exist');
      }

      return UserModel.fromMap(user);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UserModel> getUserData(String id) async {
    try {
      final userMap =
          await supabaseClient.from('users').select().eq('id', id).single();
      if (userMap.isEmpty) {
        throw Exception('This user does not exist');
      }

      final user = UserModel.fromMap(userMap);
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<dynamic> saveUserToDb(
      String email, String username, String major) async {
    try {
      final response = await supabaseClient
          .from('user')
          .insert({'email': email, 'username': username, 'major': major});

      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> userExist(String username) async {
    try {
      final user = await supabaseClient
          .from('users')
          .select()
          .eq('username', username)
          .maybeSingle();
      return user != null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
