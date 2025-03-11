import 'package:xylo/data/models/post_model.dart';
import 'package:xylo/domain/repositories/like_repository.dart';

class AddLikePost {
  final LikeRepository likeRepository;
  AddLikePost({required this.likeRepository});

  Future<void> call(PostModel post, String userId) async {
    await likeRepository.addLike(post, userId);
  }
}
