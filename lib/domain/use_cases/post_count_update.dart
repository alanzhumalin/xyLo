import 'package:xylo/data/models/user_model.dart';
import 'package:xylo/domain/repositories/user_repository.dart';

class PostCountUpdate {
  final UserRepository userRepository;
  PostCountUpdate({required this.userRepository});

  Future<void> call(UserModel user) async {
    await userRepository.postCountUpdate(user);
  }
}
