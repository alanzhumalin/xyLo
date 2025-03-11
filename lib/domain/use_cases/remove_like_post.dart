import 'package:xylo/data/models/post_model.dart';
import 'package:xylo/domain/repositories/like_repository.dart';

class RemoveLikePost {
  final LikeRepository likeRepository;
  RemoveLikePost({required this.likeRepository});

  Future<void> call(PostModel post, String userId) async {
    await likeRepository.removeLike(post, userId);
  }
}
