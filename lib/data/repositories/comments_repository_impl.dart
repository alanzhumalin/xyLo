import 'package:xylo/data/data_sources/comments_service.dart';
import 'package:xylo/data/models/comments_model.dart';
import 'package:xylo/data/models/post_model.dart';
import 'package:xylo/domain/repositories/comments_repository.dart';

class CommentsRepositoryImpl implements CommentsRepository {
  final CommentsService commentsService;
  CommentsRepositoryImpl({required this.commentsService});

  @override
  Future<void> removeCommentary(PostModel post, String userId) async {
    await commentsService.removeCommentary(post, userId);
  }

  @override
  Future<void> addCommentary(String userId, PostModel post, String text) async {
    await commentsService.addCommentary(userId, post, text);
  }

  @override
  Future<List<CommentsModel>?> getComments(PostModel post) async {
    return await commentsService.getComments(post);
  }
}
