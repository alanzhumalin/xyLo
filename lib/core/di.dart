import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:xylo/data/data_sources/auth_service.dart';
import 'package:xylo/data/data_sources/user_service.dart';
import 'package:xylo/data/repositories/auth_repository_impl.dart';
import 'package:xylo/data/repositories/user_repository_impl.dart';
import 'package:xylo/domain/repositories/auth_repository.dart';
import 'package:xylo/domain/repositories/user_repository.dart';
import 'package:xylo/domain/use_cases/get_current_user_data.dart';
import 'package:xylo/domain/use_cases/get_user_data.dart';
import 'package:xylo/domain/use_cases/register_usecase.dart';
import 'package:xylo/domain/use_cases/save_user_changes_usecase.dart';
import 'package:xylo/domain/use_cases/save_user_todb.dart';
import 'package:xylo/domain/use_cases/sign_in_usecase.dart';
import 'package:xylo/domain/use_cases/sign_out_usecase.dart';
import 'package:xylo/domain/use_cases/user_exist_usecase.dart';

final SupabaseClient supabaseClient = Supabase.instance.client;

final AuthService authService = AuthService(supabaseClient: supabaseClient);
final UserService userService = UserService(supabaseClient: supabaseClient);

final AuthRepository authRepository =
    AuthRepositoryImpl(authService: authService);
final UserRepository userRepository =
    UserRepositoryImpl(userService: userService);

final GetCurrentUserData getCurrentUserData =
    GetCurrentUserData(userRepository: userRepository);
final GetUserData getUserData = GetUserData(userRepository: userRepository);
final UserExistUsecase userExistUsecase =
    UserExistUsecase(userRepository: userRepository);
final RegisterUsecase registerUsecase =
    RegisterUsecase(authRepository: authRepository);
final SaveUserTodb saveUserTodb = SaveUserTodb(userRepository: userRepository);
final SignInUsecase signInUsecase =
    SignInUsecase(authRepository: authRepository);
final SignOutUsecase signOutUsecase =
    SignOutUsecase(authRepository: authRepository);

final SaveUserChangesUsecase saveUserChangesUsecase =
    SaveUserChangesUsecase(userRepository: userRepository);
