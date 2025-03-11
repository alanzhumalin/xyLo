import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:xylo/data/models/comments_model.dart';
import 'package:xylo/data/models/post_model.dart';

class CommentsService {
  final SupabaseClient supabaseClient;
  CommentsService({required this.supabaseClient});

  Future<void> addCommentary(String userId, PostModel post, String text) async {
    try {
      final uuid = Uuid();
      final commentId = uuid.v4();

      final comment = CommentsModel(
          id: commentId,
          userId: post.userId,
          postId: post.id,
          text: text,
          createdAt: DateTime.now());
      await supabaseClient.from('comments').insert(comment.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> removeCommentary(PostModel post, String userId) async {
    try {
      await supabaseClient
          .from('comments')
          .delete()
          .eq('user_id', userId)
          .eq('post_id', post.id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<CommentsModel>?> getComments(PostModel post) async {
    try {
      final response = await supabaseClient.rpc(
        'fetch_comments_with_users',
        params: {'post_id': post.id},
      );
      final data = response as List<dynamic>;
      if (data.isEmpty) {
        return null;
      }

      final comments = data.map((com) => CommentsModel.fromMap(com)).toList();

      return comments;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
