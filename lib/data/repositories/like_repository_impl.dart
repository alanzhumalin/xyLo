import 'package:xylo/data/data_sources/like_service.dart';
import 'package:xylo/data/models/post_model.dart';
import 'package:xylo/domain/repositories/like_repository.dart';

class LikeRepositoryImpl implements LikeRepository {
  final LikeService likeService;
  LikeRepositoryImpl({required this.likeService});

  @override
  Future<void> addLike(PostModel post, String userId) async {
    await likeService.addLike(post, userId);
  }

  @override
  Future<void> removeLike(PostModel post, String userId) async {
    await likeService.removeLike(post, userId);
  }
}
