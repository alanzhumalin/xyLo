import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xylo/logic/nav_bar/navbar_event.dart';
import 'package:xylo/logic/nav_bar/navbar_state.dart';

class NavbarBloc extends Bloc<NavbarEvent, NavbarState> {
  NavbarBloc() : super(NavbarInitial()) {
    on<ChangePage>(
      (event, emit) {
        emit(NavbarNewPage(index: event.index));
      },
    );
  }
}
