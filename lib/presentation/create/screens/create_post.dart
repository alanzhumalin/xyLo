import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xylo/core/constants.dart';
import 'package:xylo/logic/auth/auth_bloc.dart';
import 'package:xylo/logic/auth/auth_state.dart';
import 'package:xylo/logic/create_post/create_post_bloc.dart';
import 'package:xylo/logic/create_post/create_post_event.dart';
import 'package:xylo/logic/create_post/create_post_state.dart';
import 'package:xylo/logic/post/post_bloc.dart';
import 'package:xylo/logic/profile/profile_bloc.dart';
import 'package:xylo/logic/profile/profile_event.dart';
import 'package:xylo/logic/profile/profile_state.dart';
import 'package:xylo/presentation/auth/screens/widgets/custom_button.dart';
import 'package:xylo/presentation/auth/screens/widgets/loading_button.dart';

import '../../../logic/post/post_event.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _titleController = TextEditingController();
  final imagePicker = ImagePicker();
  final imageCropper = ImageCropper();
  final _key = GlobalKey<FormState>();
  bool isSelected = false;
  XFile? pickedFile;

  Future<void> pickImage() async {
    final photo = await imagePicker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      final finalPhoto = await imageCropper.cropImage(sourcePath: photo.path);
      if (finalPhoto != null) {
        setState(() {
          pickedFile = XFile(finalPhoto.path);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Create post',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          centerTitle: true,
          forceMaterialTransparency: true,
        ),
        body: Padding(
          padding: padding,
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () async {
                    await pickImage();
                  },
                  child: pickedFile != null
                      ? Image.file(
                          height: 200,
                          width: double.infinity,
                          File(pickedFile!.path))
                      : Container(
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color.fromARGB(255, 52, 52, 52)),
                          child: Center(
                              child: Text(
                            'Pick a picture',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                        ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Title',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                SizedBox(
                  height: 4,
                ),
                TextFormField(
                    controller: _titleController,
                    showCursor: true,
                    maxLines: 2,
                    cursorColor: Colors.blue,
                    decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        hintText: 'For example: I joined to club',
                        fillColor: const Color.fromARGB(255, 74, 74, 74),
                        filled: true,
                        hintStyle: TextStyle(
                            color: const Color.fromARGB(255, 228, 228, 228)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5)),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(5))),
                    validator: (value) {
                      if (value == null || value.length < 2) {
                        return 'At least 2 characters';
                      }
                      return null;
                    }),
                SizedBox(
                  height: 7,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Enable anonymous mode',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    Switch(
                        trackOutlineColor: WidgetStateColor.transparent,
                        activeColor: Colors.white,
                        activeTrackColor: Colors.green,
                        value: isSelected,
                        onChanged: (newvalue) {
                          setState(() {
                            isSelected = newvalue;
                          });
                        })
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                BlocConsumer<CreatePostBloc, CreatePostState>(
                    listener: (context, state) async {
                  if (state is CreatePostError) {
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
                                  child: Text('ОК'))
                            ],
                          );
                        });
                  }
                  if (state is CreatePostSuccessful) {
                    await showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Post created',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                                ]),
                          );
                        });

                    setState(() {
                      pickedFile = null;
                      _titleController.clear();
                      isSelected = false;
                    });
                    if (context.mounted) {
                      context
                          .read<ProfileBloc>()
                          .add(LoadUserProfile(id: state.id));
                      final authState = context.read<AuthBloc>().state;
                      if (authState is AuthSuccessful) {
                        context.read<PostBloc>().add(
                            PostLoadRequest(userId: authState.userModel.id));
                      }
                    }
                  }
                }, builder: (context, state) {
                  if (state is CreatePostLoading) {
                    return LoadingButton();
                  }
                  return BlocBuilder<ProfileBloc, ProfileState>(
                      builder: (context, state) {
                    String userId = '';
                    if (state is ProfileLoaded) {
                      userId = state.user.id;
                    }
                    return CustomButton(
                        function: () {
                          if (_key.currentState!.validate()) {
                            final state = context.read<ProfileBloc>().state;
                            if (state is ProfileLoaded) {
                              context.read<CreatePostBloc>().add(CreateRequest(
                                  user: state.user,
                                  file: File(pickedFile!.path),
                                  userId: userId,
                                  isAnonymous: isSelected,
                                  title: _titleController.text));
                            }
                          }
                        },
                        title: 'Create');
                  });
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
