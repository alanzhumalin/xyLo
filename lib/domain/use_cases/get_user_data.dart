import 'package:xylo/data/models/user_model.dart';
import 'package:xylo/domain/repositories/user_repository.dart';

class GetUserData {
  final UserRepository userRepository;
  GetUserData({required this.userRepository});

  Future<UserModel> call(String id) async {
    return await userRepository.getUserData(id);
  }
}
