import 'package:xylo/domain/repositories/user_repository.dart';

class SaveUserTodb {
  final UserRepository userRepository;
  SaveUserTodb({required this.userRepository});

  Future<dynamic> call(String email, String username, String major) async {
    return await userRepository.saveUserToDb(email, username, major);
  }
}
