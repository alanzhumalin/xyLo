import 'package:xylo/data/models/comments_model.dart';
import 'package:xylo/data/models/post_model.dart';
import 'package:xylo/domain/repositories/comments_repository.dart';

class GetCommentaries {
  final CommentsRepository commentsRepository;
  GetCommentaries({required this.commentsRepository});

  Future<List<CommentsModel>?> call(PostModel post) async {
    return await commentsRepository.getComments(post);
  }
}
