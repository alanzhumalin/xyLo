import 'package:xylo/data/data_sources/user_service.dart';
import 'package:xylo/data/models/user_model.dart';
import 'package:xylo/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserService userService;
  UserRepositoryImpl({required this.userService});
  @override
  Future<dynamic> saveUserToDb(
      String email, String username, String major) async {
    return await userService.saveUserToDb(email, username, major);
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
}
