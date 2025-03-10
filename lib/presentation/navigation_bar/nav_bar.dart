import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xylo/logic/nav_bar/navbar_bloc.dart';
import 'package:xylo/logic/nav_bar/navbar_event.dart';
import 'package:xylo/logic/nav_bar/navbar_state.dart';
import 'package:xylo/presentation/chat/screens/chats.dart';
import 'package:xylo/presentation/create/screens/create_post.dart';
import 'package:xylo/presentation/post/screens/lenta.dart';
import 'package:xylo/presentation/profile/screens/my_profile.dart';
import 'package:xylo/presentation/search/screens/search.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});
  static final List<Widget> _pages = [
    Lenta(),
    Search(),
    CreatePost(),
    Chats(),
    MyProfile()
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarBloc, NavbarState>(builder: (context, state) {
      return Scaffold(
        body: _pages[state.index],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          selectedItemColor: const Color.fromARGB(255, 217, 0, 255),
          currentIndex: state.index,
          onTap: (index) {
            context.read<NavbarBloc>().add(ChangePage(index: index));
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Лента"),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Поиск"),
            BottomNavigationBarItem(icon: Icon(Icons.add), label: "Создать"),
            BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Чаты"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Профиль"),
          ],
        ),
      );
    });
  }
}
