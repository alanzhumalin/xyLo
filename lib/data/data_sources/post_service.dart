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

  Future<List<PostModel>?> fetchAllPosts() async {
    try {
      final postsList = await supabaseClient.from('posts').select();

      if (postsList.isEmpty) {
        return null;
      }

      final posts = postsList.map((post) => PostModel.fromMap(post)).toList();

      return posts;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
