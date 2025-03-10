import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xylo/data/models/post_model.dart';
import 'package:xylo/domain/use_cases/get_user_data.dart';
import 'package:xylo/domain/use_cases/get_user_posts.dart';
import 'package:xylo/domain/use_cases/save_user_avatar.dart';
import 'package:xylo/domain/use_cases/save_user_changes_usecase.dart';
import 'package:xylo/domain/use_cases/user_exist_usecase.dart';
import 'package:xylo/logic/profile/profile_event.dart';
import 'package:xylo/logic/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  GetUserData getUserData;
  SaveUserChangesUsecase saveUserChangesUsecase;
  SaveUserAvatar saveUserAvatar;
  GetUserPosts getUserPosts;
  UserExistUsecase userExistUsecase;
  ProfileBloc(
      {required this.saveUserAvatar,
      required this.getUserData,
      required this.userExistUsecase,
      required this.getUserPosts,
      required this.saveUserChangesUsecase})
      : super(ProfileInitial()) {
    on<LoadUserProfile>(
      (event, emit) async {
        try {
          emit(ProfileLoading());
          final user = await getUserData(event.id);
          final posts = await getUserPosts(event.id);
          emit(ProfileLoaded(user: user, postModel: posts));
        } catch (e) {
          emit(ProfileError(message: e.toString()));
        }
      },
    );
    on<ChangeProfileDetails>(
      (event, emit) async {
        try {
          final currentState = state;
          List<PostModel>? posts;
          if (currentState is ProfileLoaded) {
            posts = currentState.postModel;
          }
          emit(ProfileLoading());

          final check = await userExistUsecase.call(event.userModel.username);
          if (check) {
            emit(ProfileError(message: 'This username already exist.'));
            return;
          }
          String? url;
          if (event.file != null) {
            url = await saveUserAvatar(event.file!, event.userModel.id);
          }

          final user =
              event.userModel.copyWith(avatar: url ?? event.userModel.avatar);

          await saveUserChangesUsecase(user);

          emit(ProfileLoaded(user: user, postModel: posts));
        } catch (e) {
          emit(ProfileError(message: e.toString()));
        }
      },
    );
  }
}
