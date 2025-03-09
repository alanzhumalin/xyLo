import 'package:xylo/domain/repositories/user_repository.dart';

class UserExistUsecase {
  final UserRepository userRepository;
  UserExistUsecase({required this.userRepository});

  Future<bool> call(String username) async {
    return await userRepository.userExist(username);
  }
}
