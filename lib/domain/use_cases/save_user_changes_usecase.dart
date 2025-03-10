import 'package:xylo/data/models/user_model.dart';
import 'package:xylo/domain/repositories/user_repository.dart';

class SaveUserChangesUsecase {
  UserRepository userRepository;

  SaveUserChangesUsecase({required this.userRepository});

  Future<void> call(UserModel user) async {
    await userRepository.saveUserChanges(user);
  }
}
