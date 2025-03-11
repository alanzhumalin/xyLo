import 'package:xylo/data/models/post_model.dart';
import 'package:xylo/domain/repositories/comments_repository.dart';

class AddCommentary {
  final CommentsRepository commentsRepository;
  AddCommentary({required this.commentsRepository});

  Future<void> call(String userId, PostModel post, String text) async {
    await commentsRepository.addCommentary(userId, post, text);
  }
}
