import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:xylo/data/models/like_model.dart';
import 'package:xylo/data/models/post_model.dart';

class LikeService {
  final SupabaseClient supabaseClient;
  LikeService({required this.supabaseClient});

  Future<void> addLike(PostModel post, String userId) async {
    try {
      final uuid = Uuid();
      final likeId = uuid.v4();
      final like = LikeModel(
          id: likeId,
          createdAt: DateTime.now(),
          postId: post.id,
          userId: userId);
      await supabaseClient.from('likes').insert(like.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> removeLike(PostModel post, String userId) async {
    try {
      await supabaseClient
          .from('likes')
          .delete()
          .eq('user_id', userId)
          .eq('post_id', post.id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
