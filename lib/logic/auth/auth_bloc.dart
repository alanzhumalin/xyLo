import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xylo/data/models/user_model.dart';
import 'package:xylo/domain/use_cases/get_user_data.dart';
import 'package:xylo/domain/use_cases/register_usecase.dart';
import 'package:xylo/domain/use_cases/save_user_todb.dart';
import 'package:xylo/domain/use_cases/sign_in_usecase.dart';
import 'package:xylo/domain/use_cases/sign_out_usecase.dart';
import 'package:xylo/domain/use_cases/user_exist_usecase.dart';
import 'package:xylo/logic/auth/auth_event.dart';
import 'package:xylo/logic/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUsecase signInUsecase;
  final SignOutUsecase signOutUsecase;
  final SaveUserTodb saveUserTodb;
  final RegisterUsecase registerUsecase;
  final GetUserData getUserData;
  final UserExistUsecase userExistUsecase;
  AuthBloc(
      {required this.getUserData,
      required this.userExistUsecase,
      required this.registerUsecase,
      required this.saveUserTodb,
      required this.signInUsecase,
      required this.signOutUsecase})
      : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      try {
        emit(AuthLoading());

        final response = await signInUsecase(event.email, event.password);
        if (response.user == null) {
          emit(AuthError(error: 'This user does not exist'));
          return;
        }

        final user = await getUserData(response.user!.id);
        emit(AuthSuccessful(userModel: user));
      } catch (e) {
        emit(AuthError(error: e.toString()));
      }
    });
    on<RegisterRequested>((event, emit) async {
      try {
        emit(AuthLoading());
        final isUserExist = await userExistUsecase(event.username);
        if (isUserExist) {
          emit(AuthError(
              error: 'This username already exist, pls user another one'));
          return;
        }
        final responseAuth = await registerUsecase(event.email, event.password);
        if (responseAuth.user == null) {
          emit(AuthError(error: 'Error occured by registering a new user'));
          return;
        }

        await saveUserTodb(
            responseAuth.user!.id, event.email, event.username, event.major);

        String id = responseAuth.user!.id;
        emit(AuthSuccessful(
            userModel: UserModel(
                id: id,
                email: event.email,
                major: event.major,
                postCount: 0,
                subscribers: 0,
                createdAt: DateTime.now(),
                avatar: '',
                username: event.username)));
      } catch (e) {
        emit(AuthError(error: e.toString()));
      }
    });
    on<LogOut>((event, emit) async {
      try {
        await signOutUsecase();
        emit(AuthInitial());
      } catch (e) {
        emit(AuthError(error: e.toString()));
      }
    });

    on<AppStarted>((event, emit) async {
      if (event.userModel != null) {
        emit(AuthSuccessful(userModel: event.userModel!));

        return;
      }
      emit(AuthInitial());
    });
  }
}
