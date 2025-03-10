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
      final userMap = await supabaseClient
          .from('users')
          .select('*')
          .eq('id', id)
          .maybeSingle();

      if (userMap == null) {
        throw Exception('This user does not exist');
      }

      final user = UserModel.fromMap(userMap);

      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> saveUserToDb(
      String id, String email, String username, String major) async {
    try {
      final user = UserModel(
          id: id,
          email: email,
          major: major,
          username: username,
          avatar: '',
          createdAt: DateTime.now(),
          postCount: 0,
          subscribers: 0);
      final response = await supabaseClient.from('users').insert(user.toMap());

      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> saveUserChanges(UserModel user) async {
    try {
      final response = await supabaseClient
          .from('users')
          .update(user.toMap())
          .eq('id', user.id)
          .select()
          .maybeSingle();
      if (response == null) {
        throw Exception('Error occured while saving new user data to DB');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> userExist(String username) async {
    try {
      final user = await supabaseClient
          .from('users')
          .select('*')
          .eq('username', username)
          .maybeSingle();
      return user != null;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
