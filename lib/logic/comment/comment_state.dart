import 'package:xylo/data/models/comments_model.dart';

abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final List<CommentsModel> comments;
  CommentLoaded({required this.comments});
}

class CommentError extends CommentState {
  final String message;
  CommentError({required this.message});
}
