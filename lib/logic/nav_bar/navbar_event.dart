sealed class NavbarEvent {}

class ChangePage extends NavbarEvent {
  final int index;
  ChangePage({required this.index});
}
