import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:xylo/core/di.dart';
import 'package:xylo/core/simple_bloc_observer.dart';
import 'package:xylo/data/models/user_model.dart';
import 'package:xylo/domain/use_cases/get_current_user_data.dart';
import 'package:xylo/logic/auth/auth_bloc.dart';
import 'package:xylo/logic/auth/auth_event.dart';
import 'package:xylo/logic/create_post/create_post_bloc.dart';
import 'package:xylo/logic/nav_bar/navbar_bloc.dart';
import 'package:xylo/logic/profile/profile_bloc.dart';
import 'package:xylo/presentation/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!);
  Bloc.observer = SimpleBlocObserver();
  final session = Supabase.instance.client.auth.currentSession;
  UserModel? userModel;
  if (session != null) {
    final getCurrentUserData =
        GetCurrentUserData(userRepository: userRepository);

    userModel = await getCurrentUserData();
  }
  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (context) => AuthBloc(
            getUserData: getUserData,
            userExistUsecase: userExistUsecase,
            registerUsecase: registerUsecase,
            saveUserTodb: saveUserTodb,
            signInUsecase: signInUsecase,
            signOutUsecase: signOutUsecase)
          ..add(AppStarted(userModel: userModel))),
    BlocProvider(create: (context) => NavbarBloc()),
    BlocProvider(
        create: (context) => ProfileBloc(
            userExistUsecase: userExistUsecase,
            saveUserAvatar: saveUserAvatar,
            getUserData: getUserData,
            saveUserChangesUsecase: saveUserChangesUsecase,
            getUserPosts: getUserPosts)),
    BlocProvider(
        create: (context) => CreatePostBloc(
            postCountUpdate: postCountUpdate,
            saveImageTodb: saveImageTodb,
            savePostTodb: savePostTodb)),
  ], child: const MyApp()));
}
