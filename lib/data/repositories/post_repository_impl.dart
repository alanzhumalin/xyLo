import 'dart:io';

import 'package:xylo/data/data_sources/post_service.dart';
import 'package:xylo/data/models/post_model.dart';
import 'package:xylo/domain/repositories/post_repository.dart';

class PostRepositoryImpl extends PostRepository {
  final PostService postService;
  PostRepositoryImpl({required this.postService});

  @override
  Future<void> savePostToDB(PostModel post) async {
    await postService.savePostToDB(post);
  }

  @override
  Future<String> saveImageToDB(File file, String userId, String postId) async {
    return await postService.saveImageToDB(file, userId, postId);
  }

  @override
  Future<List<PostModel>?> fetchAllPosts() async {
    return await postService.fetchAllPosts();
  }
}
