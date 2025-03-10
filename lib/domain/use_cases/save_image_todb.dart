import 'dart:io';

import 'package:xylo/domain/repositories/post_repository.dart';

class SaveImageTodb {
  final PostRepository postRepository;
  SaveImageTodb({required this.postRepository});

  Future<String> call(File file, String userId, String postId) async {
    return await postRepository.saveImageToDB(file, userId, postId);
  }
}
