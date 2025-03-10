import 'dart:io';

import 'package:xylo/data/models/post_model.dart';
import 'package:xylo/data/models/user_model.dart';

abstract class UserRepository {
  Future<dynamic> saveUserToDb(
      String id, String email, String username, String major);
  Future<UserModel> getCurrentUserData();
  Future<bool> userExist(String username);
  Future<UserModel> getUserData(String id);
  Future<void> saveUserChanges(UserModel user);
  Future<String> saveUserAvatar(File file, String id);
  Future<List<PostModel>?> getUserPosts(String id);
  Future<void> postCountUpdate(UserModel user);
}
