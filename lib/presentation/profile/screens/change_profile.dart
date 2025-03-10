import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xylo/core/constants.dart';
import 'package:xylo/logic/profile/profile_bloc.dart';
import 'package:xylo/logic/profile/profile_event.dart';
import 'package:xylo/logic/profile/profile_state.dart';
import 'package:xylo/presentation/auth/screens/widgets/custom_button.dart';
import 'package:xylo/presentation/auth/screens/widgets/text_form.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({super.key});

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  final _usernameController = TextEditingController();

  final _key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change your data',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        forceMaterialTransparency: true,
        centerTitle: true,
      ),
      body: Padding(
        padding: padding,
        child:
            BlocConsumer<ProfileBloc, ProfileState>(listener: (context, state) {
          if (state is ProfileError) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(state.message),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('OK'))
                    ],
                  );
                });
          }
          if (state is ProfileLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return PopScope(
                  onPopInvokedWithResult: (_, d) async => false,
                  child: AlertDialog(
                    content: loading,
                  ),
                );
              },
            );
          }
          if (state is ProfileChanged) {
            Navigator.pop(context);
          }
        }, builder: (context, state) {
          if (state is ProfileError) {
            return Center(
              child: Text('Error ${state.message}'),
            );
          }

          if (state is ProfileLoaded) {
            final userData = state.user;
            return Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              CachedNetworkImageProvider(userData.avatar),
                          backgroundColor: Colors.purple,
                        ),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () {
                                print('object');
                              },
                              child: Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.add_a_photo,
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Username',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  TextForm(
                      validator: (value) {
                        if (value == null || value.length < 3) {
                          return 'Username must be at least 3 characters';
                        }
                        return null;
                      },
                      controller: _usernameController,
                      hinttext: userData.username),
                  SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                      function: () {
                        context
                            .read<ProfileBloc>()
                            .add(ChangeProfileDetails(userModel: userData));
                      },
                      title: 'Save')
                ],
              ),
            );
          }

          return Center(
            child: loading,
          );
        }),
      ),
    );
  }
}
