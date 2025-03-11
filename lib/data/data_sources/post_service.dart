import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:xylo/data/models/post_model.dart';

class PostService {
  final SupabaseClient supabaseClient;
  PostService({required this.supabaseClient});

  Future<String> saveImageToDB(File file, String userId, String postId) async {
    try {
      final dir = await getTemporaryDirectory();
      final webpPath = '${dir.path}/$userId.webp';

      final compressedBytes = await FlutterImageCompress.compressWithFile(
        file.absolute.path,
        format: CompressFormat.webp,
        quality: 20,
      );

      final webpFile = File(webpPath);
      await webpFile.writeAsBytes(compressedBytes!);

      final filePath = '$userId/$postId.webp';

      final response = await Supabase.instance.client.storage
          .from('post_images')
          .upload(filePath, webpFile);

      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> savePostToDB(PostModel post) async {
    try {
      await supabaseClient.from('posts').insert(post.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<PostModel>?> fetchAllPosts(String userId) async {
    try {
      final response = await supabaseClient
          .rpc('fetch_posts_with_counts', params: {'user_uuid': userId});

      final postsList = response as List<dynamic>;

      if (postsList.isEmpty) {
        return null;
      }

      final List<PostModel> posts = postsList
          .map((post) => PostModel.fromMap(post as Map<String, dynamic>))
          .toList();

      return posts;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
