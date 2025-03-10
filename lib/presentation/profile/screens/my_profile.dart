import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xylo/core/constants.dart';
import 'package:xylo/logic/auth/auth_bloc.dart';
import 'package:xylo/logic/auth/auth_event.dart';
import 'package:xylo/logic/auth/auth_state.dart';
import 'package:xylo/logic/profile/profile_bloc.dart';
import 'package:xylo/logic/profile/profile_event.dart';
import 'package:xylo/logic/profile/profile_state.dart';
import 'package:xylo/presentation/auth/screens/login.dart';
import 'package:xylo/presentation/profile/screens/change_profile.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        forceMaterialTransparency: true,
      ),
      endDrawer: Drawer(
        child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthInitial) {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                    (Route<dynamic> route) => false);
              }
            },
            child: ListView(
              children: [
                DrawerHeader(
                    padding: EdgeInsets.all(0),
                    child: Center(
                      child: Text(
                        'ADVANCED',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    )),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangeProfile()));
                  },
                  trailing: Icon(Icons.edit),
                  title: Text(
                    'Change profile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                    onTap: () {
                      context.read<AuthBloc>().add(LogOut());
                    },
                    trailing: Icon(Icons.exit_to_app),
                    title: Text(
                      'Exit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: loadingColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      onPressed: () {},
                      child: Text(
                        'Contact to admin',
                        style: textStyle.copyWith(fontSize: 15),
                      )),
                )
              ],
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return Center(
                child: loading,
              );
            }
            if (state is ProfileError) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is ProfileLoaded) {
              final user = state.user;
              return RefreshIndicator(
                color: Colors.blue,
                onRefresh: () async {
                  context.read<ProfileBloc>().add(LoadUserProfile(id: user.id));
                },
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                              user.avatar),
                                      radius: 50,
                                    ),
                                    const SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '@${user.username}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17),
                                        ),
                                        Text(
                                          user.major,
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    _buildInfoBlock("Posts", user.postCount),
                                    _buildInfoBlock(
                                        "Subscribers", user.subscribers),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                                child: Divider(
                              endIndent: 10,
                              thickness: 0.4,
                            )),
                            Text(
                              'My posts',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                                child: Divider(
                              indent: 10,
                              thickness: 0.4,
                            )),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: CachedNetworkImage(
                                        imageUrl:
                                            'https://i.redd.it/the-legendary-bmw-m3-gtr-nfsmw-at-bmw-welt-munich-v0-zss37de6ne4e1.jpg?width=5712&format=pjpg&auto=webp&s=d530d45a0be60e8aff1635ed24dffa744c9111c7'),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      'Today i saw my dream from my child. As you can it is BMW m3 gtr from NFS MW 2005. It was really gorgeous. Amazing'),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                print('object');
                                              },
                                              child: Icon(
                                                Icons.favorite_border_rounded,
                                                size: 20,
                                              )),
                                          SizedBox(
                                            width: 3,
                                          ),
                                          Text('14')
                                        ],
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                              onTap: () {
                                                print('object');
                                              },
                                              child: Icon(
                                                Icons.comment,
                                                size: 20,
                                              )),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text('3')
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            }

            return Center(child: loading);
          },
        ),
      ),
    );
  }

  Widget _buildInfoBlock(String title, int count) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(
          title,
          style: TextStyle(color: Colors.grey.shade600),
        ),
      ],
    );
  }
}
