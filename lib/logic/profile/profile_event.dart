import 'package:xylo/data/models/user_model.dart';

sealed class ProfileEvent {}

class LoadUserProfile extends ProfileEvent {
  final String id;
  LoadUserProfile({required this.id});
}

class ChangeProfileDetails extends ProfileEvent {
  UserModel userModel;
  ChangeProfileDetails({required this.userModel});
}
