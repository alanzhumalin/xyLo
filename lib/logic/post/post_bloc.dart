import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xylo/domain/use_cases/add_commentary.dart';
import 'package:xylo/domain/use_cases/fetch_all_posts.dart';
import 'package:xylo/domain/use_cases/add_like_post.dart';
import 'package:xylo/domain/use_cases/get_comments.dart';
import 'package:xylo/domain/use_cases/remove_commentary.dart';
import 'package:xylo/domain/use_cases/remove_like_post.dart';
import 'package:xylo/logic/post/post_event.dart';
import 'package:xylo/logic/post/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final FetchAllPosts fetchAllPosts;
  final AddLikePost addLikePost;
  final RemoveLikePost removeLikePost;
  final AddCommentary addComments;
  final RemoveCommentary removeCommentary;
  final GetCommentaries getComments;
  PostBloc({
    required this.addComments,
    required this.removeCommentary,
    required this.getComments,
    required this.fetchAllPosts,
    required this.addLikePost,
    required this.removeLikePost,
  }) : super(PostInitial()) {
    on<PostLoadRequest>(
      (event, emit) async {
        try {
          emit(PostLoading());
          final posts = await fetchAllPosts(event.userId);
          if (posts == null) {
            emit(PostInitial());
            return;
          }
          emit(PostLoaded(posts: posts));
        } catch (e) {
          emit(PostError(message: e.toString()));
        }
      },
    );

    on<ToggleLike>(
      (event, emit) async {
        if (state is! PostLoaded) return;
        final currentState = state as PostLoaded;

        final updatedPosts = currentState.posts.map((post) {
          if (post.id == event.post.id) {
            return post.copyWith(
              isLiked: !post.isLiked!,
              likeCount:
                  post.isLiked! ? post.likeCount! - 1 : post.likeCount! + 1,
            );
          }
          return post;
        }).toList();

        emit(PostLoaded(posts: updatedPosts));

        if (event.post.isLiked!) {
          await removeLikePost(event.post, event.userId);
        } else {
          await addLikePost(event.post, event.userId);
        }
      },
    );
  }
}
