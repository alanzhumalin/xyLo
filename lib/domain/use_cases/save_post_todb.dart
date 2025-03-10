import 'package:xylo/data/models/post_model.dart';
import 'package:xylo/domain/repositories/post_repository.dart';

class SavePostTodb {
  final PostRepository postRepository;
  SavePostTodb({required this.postRepository});

  Future<void> call(PostModel post) async {
    await postRepository.savePostToDB(post);
  }
}
