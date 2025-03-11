import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:xylo/core/constants.dart';
import 'package:xylo/data/models/post_model.dart';
import 'package:xylo/logic/auth/auth_bloc.dart';
import 'package:xylo/logic/auth/auth_state.dart';
import 'package:xylo/logic/comment/comment_bloc.dart';
import 'package:xylo/logic/comment/comment_event.dart';
import 'package:xylo/logic/comment/comment_state.dart';
import 'package:xylo/logic/post/post_bloc.dart';
import 'package:xylo/logic/post/post_state.dart';
import 'package:xylo/presentation/post/widgets/post_details_widget.dart';

class PostDetails extends StatefulWidget {
  const PostDetails({super.key, required this.post});
  final PostModel post;

  @override
  State<PostDetails> createState() => _PostDetailsState();
}

class _PostDetailsState extends State<PostDetails> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<CommentBloc>().add(LoadComments(post: widget.post));
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Comments',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          centerTitle: true,
          forceMaterialTransparency: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: padding,
                child:
                    BlocBuilder<PostBloc, PostState>(builder: (context, state) {
                  if (state is PostLoaded) {
                    final updatedPost = state.posts
                        .where((post) => post.id == widget.post.id)
                        .firstOrNull;
                    return PostDetailsWidget(post: updatedPost!);
                  }
                  return loading;
                }),
              ),
              SizedBox(
                height: size.height / 2.7,
                child: BlocBuilder<CommentBloc, CommentState>(
                  builder: (context, state) {
                    if (state is CommentLoading) {
                      return Center(child: loading);
                    }
                    if (state is CommentLoaded) {
                      return state.comments.isNotEmpty
                          ? ListView.builder(
                              padding: const EdgeInsets.all(10),
                              itemCount: state.comments.length,
                              itemBuilder: (context, index) {
                                final comment = state.comments[index];

                                return Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        backgroundImage:
                                            CachedNetworkImageProvider(
                                          comment.avatar!.isNotEmpty
                                              ? dotenv.env['AVATAR_URL']! +
                                                  comment.avatar!
                                              : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtuphMb4mq-EcVWhMVT8FCkv5dqZGgvn_QiA&s',
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              comment.username!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              comment.text,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                              softWrap: true,
                                              overflow: TextOverflow.visible,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        DateFormat('d MMM yyyy, HH:mm', 'en')
                                            .format(comment.createdAt),
                                        style: const TextStyle(
                                            fontSize: 10, color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            )
                          : const Center(child: Text("No comments yet"));
                    }
                    return const Center(child: Text("Failed to load comments"));
                  },
                ),
              ),
              _commentInputField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _commentInputField() {
    return Container(
      color: const Color.fromARGB(255, 25, 25, 25),
      padding: const EdgeInsets.only(bottom: 30, left: 20, right: 10, top: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _commentController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 20),
                hintText: 'Type a comment...',
                fillColor: Colors.grey[850],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: () {
              final text = _commentController.text;
              if (text.isNotEmpty) {
                final state = context.read<AuthBloc>().state;
                if (state is AuthSuccessful) {
                  context.read<CommentBloc>().add(
                        AddComment(
                            text: text,
                            post: widget.post,
                            userId: state.userModel.id,
                            userModel: state.userModel),
                      );
                  _commentController.clear();
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
