import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xylo/logic/auth/auth_event.dart';
import 'package:xylo/logic/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {});
    on<RegisterRequested>((event, emit) async {});
    on<LogOut>((event, emit) async {});
  }
}
