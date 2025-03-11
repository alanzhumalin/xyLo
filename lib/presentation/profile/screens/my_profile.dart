import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:xylo/core/constants.dart';
import 'package:xylo/data/models/post_model.dart';
import 'package:xylo/logic/auth/auth_bloc.dart';
import 'package:xylo/logic/auth/auth_event.dart';
import 'package:xylo/logic/auth/auth_state.dart';
import 'package:xylo/logic/post/post_bloc.dart';
import 'package:xylo/logic/post/post_state.dart';
import 'package:xylo/logic/profile/profile_bloc.dart';
import 'package:xylo/logic/profile/profile_event.dart';
import 'package:xylo/logic/profile/profile_state.dart';
import 'package:xylo/presentation/auth/screens/login.dart';
import 'package:xylo/presentation/profile/screens/change_profile.dart';
import 'package:xylo/presentation/profile/widgets/post_widget.dart';

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
                    final state = context.read<ProfileBloc>().state;
                    if (state is ProfileLoaded) {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangeProfile(
                                    user: state.user,
                                  )));
                    }
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
                                        user.avatar.isNotEmpty
                                            ? dotenv.env['AVATAR_URL']! +
                                                user.avatar
                                            : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtuphMb4mq-EcVWhMVT8FCkv5dqZGgvn_QiA&s',
                                      ),
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
                        BlocBuilder<PostBloc, PostState>(
                          builder: (context, state) {
                            if (state is PostLoaded) {
                              final authState = context.read<AuthBloc>().state;
                              List<PostModel>? userPosts;
                              if (authState is AuthSuccessful) {
                                userPosts = state.posts
                                    .where((post) =>
                                        post.userId == authState.userModel.id)
                                    .toList();
                              }

                              if (userPosts == null || userPosts.isEmpty) {
                                return Center(child: Text('No posts'));
                              }

                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: userPosts.length,
                                itemBuilder: (context, index) {
                                  final post = userPosts![index];
                                  return PostWidget(post: post);
                                },
                              );
                            }
                            return Center(child: loading);
                          },
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
