import 'package:xylo/data/models/comments_model.dart';
import 'package:xylo/data/models/post_model.dart';

abstract class CommentsRepository {
  Future<void> removeCommentary(PostModel post, String userId);
  Future<void> addCommentary(String userId, PostModel post, String text);

  Future<List<CommentsModel>?> getComments(PostModel post);
}
