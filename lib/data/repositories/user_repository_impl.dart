import 'dart:io';

import 'package:xylo/data/data_sources/user_service.dart';
import 'package:xylo/data/models/user_model.dart';
import 'package:xylo/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService userService;
  UserRepositoryImpl({required this.userService});
  @override
  Future<dynamic> saveUserToDb(
      String id, String email, String username, String major) async {
    return await userService.saveUserToDb(id, email, username, major);
  }

  @override
  Future<UserModel> getCurrentUserData() async {
    return await userService.getCurrentUserData();
  }

  @override
  Future<UserModel> getUserData(String id) async {
    return await userService.getUserData(id);
  }

  @override
  Future<bool> userExist(String username) async {
    return await userService.userExist(username);
  }

  @override
  Future<void> saveUserChanges(UserModel user) async {
    await userService.saveUserChanges(user);
  }

  @override
  Future<String> saveUserAvatar(File file, String id) async {
    return await userService.saveUserAvatar(file, id);
  }

  @override
  Future<void> postCountUpdate(UserModel user) async {
    await userService.postCountUpdate(user);
  }
}
