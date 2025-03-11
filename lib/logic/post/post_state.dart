import 'package:xylo/data/models/post_model.dart';

sealed class PostState {}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  List<PostModel> posts;
  PostLoaded({required this.posts});
}

class PostError extends PostState {
  final String message;
  PostError({required this.message});
}
