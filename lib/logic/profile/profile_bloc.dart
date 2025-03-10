import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xylo/domain/use_cases/get_user_data.dart';
import 'package:xylo/domain/use_cases/save_user_changes_usecase.dart';
import 'package:xylo/logic/profile/profile_event.dart';
import 'package:xylo/logic/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  GetUserData getUserData;
  SaveUserChangesUsecase saveUserChangesUsecase;
  ProfileBloc({required this.getUserData, required this.saveUserChangesUsecase})
      : super(ProfileInitial()) {
    on<LoadUserProfile>(
      (event, emit) async {
        try {
          emit(ProfileLoading());
          final user = await getUserData(event.id);

          emit(ProfileLoaded(user: user));
        } catch (e) {
          emit(ProfileError(message: e.toString()));
        }
      },
    );
    on<ChangeProfileDetails>(
      (event, emit) async {
        try {
          emit(ProfileLoading());
          final user = event.userModel;
          await saveUserChangesUsecase(user);
          emit(ProfileChanged());
          await Future.delayed(const Duration(seconds: 1));
          emit(ProfileLoaded(user: user));
        } catch (e) {
          throw Exception(e.toString());
        }
      },
    );
  }
}
