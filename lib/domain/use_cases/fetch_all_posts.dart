import 'package:xylo/data/models/post_model.dart';
import 'package:xylo/domain/repositories/post_repository.dart';

class FetchAllPosts {
  final PostRepository postRepository;
  FetchAllPosts({required this.postRepository});

  Future<List<PostModel>?> call(String userId) async {
    return await postRepository.fetchAllPosts(userId);
  }
}
