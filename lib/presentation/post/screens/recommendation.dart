import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xylo/core/constants.dart';
import 'package:xylo/logic/auth/auth_bloc.dart';
import 'package:xylo/logic/auth/auth_state.dart';
import 'package:xylo/logic/post/post_bloc.dart';
import 'package:xylo/logic/post/post_event.dart';
import 'package:xylo/logic/post/post_state.dart';
import 'package:xylo/presentation/post/widgets/custom_post_widget.dart';

class Recommendation extends StatelessWidget {
  const Recommendation({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostBloc, PostState>(listener: (context, state) {
      if (state is PostError) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(state.message),
              );
            });
      }
    }, builder: (context, state) {
      if (state is PostLoaded) {
        final posts = state.posts;
        return RefreshIndicator(
          color: Colors.blue,
          onRefresh: () async {
            final state = context.read<AuthBloc>().state;
            if (state is AuthSuccessful) {
              context
                  .read<PostBloc>()
                  .add(PostLoadRequest(userId: state.userModel.id));
            }
          },
          child: ListView.builder(
              padding: EdgeInsets.only(top: 20),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return CustomPostWidget(post: post);
              }),
        );
      }
      if (state is PostLoading) {
        return loading;
      }
      return Center(child: Text('Nothing found'));
    });
  }
}
