import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xylo/data/models/comments_model.dart';
import 'package:xylo/domain/use_cases/add_commentary.dart';
import 'package:xylo/domain/use_cases/get_comments.dart';
import 'package:xylo/domain/use_cases/remove_commentary.dart';
import 'package:xylo/logic/comment/comment_event.dart';
import 'package:xylo/logic/comment/comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final AddCommentary addCommentary;
  final GetCommentaries getComments;
  final RemoveCommentary removeCommentary;

  CommentBloc({
    required this.addCommentary,
    required this.getComments,
    required this.removeCommentary,
  }) : super(CommentInitial()) {
    on<LoadComments>((event, emit) async {
      emit(CommentLoading());
      try {
        final comments = await getComments(event.post);
        emit(CommentLoaded(comments: comments ?? []));
      } catch (e) {
        emit(CommentError(message: e.toString()));
      }
    });

    on<AddComment>((event, emit) async {
      if (state is CommentLoaded) {
        final currentState = state as CommentLoaded;
        final newComment = CommentsModel(
            id: DateTime.now().toString(),
            createdAt: DateTime.now(),
            userId: event.userId,
            postId: event.post.id,
            text: event.text,
            avatar: event.userModel.avatar,
            username: event.userModel.username);

        emit(CommentLoaded(comments: [newComment, ...currentState.comments]));

        try {
          await addCommentary(event.userId, event.post, event.text);
        } catch (e) {
          emit(CommentError(message: e.toString() + 'dfsfsdfsdfdsf'));
        }
      }
    });
  }
}
