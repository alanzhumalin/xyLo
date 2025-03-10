import 'package:xylo/domain/repositories/user_repository.dart';

class SaveUserTodb {
  final UserRepository userRepository;
  SaveUserTodb({required this.userRepository});

  Future<dynamic> call(
      String id, String email, String username, String major) async {
    return await userRepository.saveUserToDb(id, email, username, major);
  }
}
