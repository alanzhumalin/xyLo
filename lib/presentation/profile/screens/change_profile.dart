import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xylo/core/constants.dart';
import 'package:xylo/data/models/user_model.dart';
import 'package:xylo/logic/profile/profile_bloc.dart';
import 'package:xylo/logic/profile/profile_event.dart';
import 'package:xylo/logic/profile/profile_state.dart';
import 'package:xylo/presentation/auth/screens/widgets/custom_button.dart';
import 'package:xylo/presentation/auth/screens/widgets/loading_button.dart';
import 'package:xylo/presentation/auth/screens/widgets/text_form.dart';

class ChangeProfile extends StatefulWidget {
  const ChangeProfile({super.key, required this.user});
  final UserModel user;
  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  final _usernameController = TextEditingController();

  final _key = GlobalKey<FormState>();
  XFile? pickedFile;
  final imagePicker = ImagePicker();
  final imageCropper = ImageCropper();
  Future<void> pickImage() async {
    final photo = await imagePicker.pickImage(source: ImageSource.gallery);
    if (photo != null) {
      final croppedPhoto = await imageCropper.cropImage(sourcePath: photo.path);

      if (croppedPhoto != null) {
        setState(() {
          pickedFile = XFile(croppedPhoto.path);
        });
      }
    }
  }

  Future<void> takePhoto() async {
    final photo = await imagePicker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      final croppedPhoto = await imageCropper.cropImage(sourcePath: photo.path);

      if (croppedPhoto != null) {
        setState(() {
          pickedFile = XFile(croppedPhoto.path);
        });
      }
    }
  }

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
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: pickedFile == null
                              ? CachedNetworkImageProvider(
                                  '${dotenv.env['AVATAR_URL']!}${widget.user.avatar}')
                              : FileImage(File(pickedFile!.path)),
                          backgroundColor: Colors.purple,
                        ),
                        Positioned(
                            right: 0,
                            bottom: 0,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                          contentPadding: EdgeInsets.all(15),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              ListTile(
                                                onTap: () async {
                                                  if (context.mounted) {
                                                    Navigator.pop(context);
                                                  }
                                                  await pickImage();
                                                },
                                                title: Text(
                                                  'From gallery',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15),
                                                ),
                                                trailing: Icon(
                                                  Icons.image,
                                                  size: 28,
                                                  color: Colors.lightGreen,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: Divider(
                                                    endIndent: 10,
                                                  )),
                                                  Text(
                                                    'OR',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 12),
                                                  ),
                                                  Expanded(
                                                      child: Divider(
                                                    indent: 10,
                                                  )),
                                                ],
                                              ),
                                              ListTile(
                                                onTap: () async {
                                                  if (context.mounted) {
                                                    Navigator.pop(context);
                                                  }
                                                  await takePhoto();
                                                },
                                                title: Text(
                                                  'Take a photo',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15),
                                                ),
                                                trailing: Icon(
                                                  Icons.camera_alt,
                                                  size: 28,
                                                  color: const Color.fromARGB(
                                                      255, 255, 255, 255),
                                                ),
                                              )
                                            ],
                                          ));
                                    });
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
                        if (value == widget.user.username) {
                          return 'Pls use another username, not the previous one';
                        }

                        return null;
                      },
                      controller: _usernameController,
                      hinttext: widget.user.username),
                  SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<ProfileBloc, ProfileState>(
                      listener: (context, state) async {
                    if (state is ProfileLoaded) {
                      await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Changes applied',
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

                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }

                    if (state is ProfileError) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              content: Text(state.message),
                              actions: [
                                TextButton(onPressed: () {}, child: Text('OK'))
                              ],
                            );
                          });
                    }
                  }, builder: (context, state) {
                    if (state is ProfileLoaded) {
                      return CustomButton(
                          function: () {
                            if (_key.currentState!.validate()) {
                              print(_usernameController.text);
                              final updatedUser = widget.user.copyWith(
                                  username: _usernameController.text.trim());
                              context.read<ProfileBloc>().add(
                                  ChangeProfileDetails(
                                      userModel: updatedUser,
                                      file: File(pickedFile!.path)));
                            }
                          },
                          title: 'Save');
                    }

                    return LoadingButton();
                  })
                ],
              ),
            )));
  }
}
