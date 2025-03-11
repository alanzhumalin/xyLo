import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:xylo/data/models/comments_model.dart';
import 'package:xylo/data/models/post_model.dart';

class CommentsService {
  final SupabaseClient supabaseClient;
  CommentsService({required this.supabaseClient});

  Future<void> addCommentary(PostModel post, String text) async {
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

  Future<void> removeCommentary(CommentsModel comment) async {
    try {
      await supabaseClient.from('comments').delete().eq('id', comment.id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<int> getCountComments(PostModel post) async {
    try {
      final res = await supabaseClient
          .from('comments')
          .select()
          .eq('post_id', post.id)
          .count(CountOption.exact);
      final count = res.count;
      return count;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
