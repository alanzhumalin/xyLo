sealed class CreatePostState {}

class CreatePostInitial extends CreatePostState {}

class CreatePostLoading extends CreatePostState {}

class CreatePostSuccessful extends CreatePostState {
  final String id;
  CreatePostSuccessful({required this.id});
}

class CreatePostError extends CreatePostState {
  final String message;
  CreatePostError({required this.message});
}
