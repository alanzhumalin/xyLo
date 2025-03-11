import 'package:xylo/data/models/post_model.dart';

abstract class LikeRepository {
  Future<void> addLike(PostModel post, String userId);

  Future<void> removeLike(PostModel post, String userId);
}
