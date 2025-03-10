import 'package:xylo/data/models/post_model.dart';
import 'package:xylo/data/models/user_model.dart';

sealed class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserModel user;
  final List<PostModel>? postModel;
  ProfileLoaded({required this.user, required this.postModel});
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError({required this.message});
}
