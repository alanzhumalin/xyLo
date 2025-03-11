import 'package:xylo/data/models/post_model.dart';
import 'package:xylo/domain/repositories/comments_repository.dart';

class RemoveCommentary {
  final CommentsRepository commentsRepository;
  RemoveCommentary({required this.commentsRepository});

  Future<void> call(String userId, PostModel post) async {
    await commentsRepository.removeCommentary(post, userId);
  }
}
