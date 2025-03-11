import 'package:xylo/data/models/post_model.dart';

sealed class PostEvent {}

class PostLoadRequest extends PostEvent {
  final String userId;
  PostLoadRequest({required this.userId});
}

class ToggleLike extends PostEvent {
  final PostModel post;
  final String userId;

  ToggleLike({required this.post, required this.userId});
}
