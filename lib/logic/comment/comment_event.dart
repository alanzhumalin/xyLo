import 'package:xylo/data/models/post_model.dart';
import 'package:xylo/data/models/user_model.dart';

abstract class CommentEvent {}

class LoadComments extends CommentEvent {
  final PostModel post;
  LoadComments({required this.post});
}

class AddComment extends CommentEvent {
  final String text;
  final PostModel post;
  final String userId;
  final UserModel userModel;
  AddComment(
      {required this.text,
      required this.userModel,
      required this.post,
      required this.userId});
}

class RemoveComment extends CommentEvent {
  final String commentId;
  final PostModel post;
  RemoveComment({required this.commentId, required this.post});
}
