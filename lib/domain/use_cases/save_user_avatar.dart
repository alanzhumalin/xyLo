import 'dart:io';

import 'package:xylo/domain/repositories/user_repository.dart';

class SaveUserAvatar {
  final UserRepository userRepository;
  SaveUserAvatar({required this.userRepository});

  Future<String> call(File file, String id) async {
    return userRepository.saveUserAvatar(file, id);
  }
}
