sealed class NavbarState {
  final int index;
  NavbarState(this.index);
}

class NavbarInitial extends NavbarState {
  NavbarInitial() : super(0);
}

class NavbarNewPage extends NavbarState {
  NavbarNewPage({required int index}) : super(index);
}
