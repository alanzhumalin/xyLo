import 'package:xylo/data/models/user_model.dart';

abstract class UserRepository {
  Future<dynamic> saveUserToDb(String email, String username, String major);
  Future<UserModel> getCurrentUserData();
  Future<bool> userExist(String username);
  Future<UserModel> getUserData(String id);
}
