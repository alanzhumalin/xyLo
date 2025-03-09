import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('BLOC EVENT: ${bloc.runtimeType} -> $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('BLOC CHANGE: ${bloc.runtimeType} -> $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('BLOC TRANSITION: ${bloc.runtimeType} -> $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('BLOC ERROR: ${bloc.runtimeType} -> $error');
    super.onError(bloc, error, stackTrace);
  }
}
