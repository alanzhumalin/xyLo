import 'dart:io';

import 'package:xylo/data/models/user_model.dart';

sealed class CreatePostEvent {}

class CreateRequest extends CreatePostEvent {
  final String title;
  final File? file;
  final bool isAnonymous;
  final String userId;
  final UserModel user;
  CreateRequest(
      {required this.file,
      required this.userId,
      required this.user,
      required this.isAnonymous,
      required this.title});
}
