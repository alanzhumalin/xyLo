import 'dart:io';

import 'package:xylo/data/models/post_model.dart';

abstract class PostRepository {
  Future<String> saveImageToDB(File file, String userId, String postId);
  Future<void> savePostToDB(PostModel post);
  Future<List<PostModel>?> fetchAllPosts(String userId);
}
