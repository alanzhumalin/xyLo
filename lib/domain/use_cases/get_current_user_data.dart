import 'package:xylo/data/models/user_model.dart';
import 'package:xylo/domain/repositories/user_repository.dart';

class GetCurrentUserData {
  final UserRepository userRepository;
  GetCurrentUserData({required this.userRepository});

  Future<UserModel> call() async {
    return await userRepository.getCurrentUserData();
  }
}
