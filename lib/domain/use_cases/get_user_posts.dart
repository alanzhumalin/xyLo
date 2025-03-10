import 'package:xylo/data/models/post_model.dart';
import 'package:xylo/domain/repositories/user_repository.dart';

class GetUserPosts {
  final UserRepository userRepository;
  GetUserPosts({required this.userRepository});

  Future<List<PostModel>?> call(String id) async {
    return await userRepository.getUserPosts(id);
  }
}
