import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:xylo/data/models/post_model.dart';
import 'package:xylo/logic/auth/auth_bloc.dart';
import 'package:xylo/logic/auth/auth_state.dart';
import 'package:xylo/logic/post/post_bloc.dart';
import 'package:xylo/logic/post/post_event.dart';

class CustomPostWidget extends StatefulWidget {
  const CustomPostWidget({super.key, required this.post});
  final PostModel post;

  @override
  State<CustomPostWidget> createState() => _CustomPostWidgetState();
}

class _CustomPostWidgetState extends State<CustomPostWidget> {
  late bool isLiked;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLiked = widget.post.isLiked!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Builder(builder: (context) {
              return Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CachedNetworkImage(
                      imageUrl:
                          dotenv.env['AVATAR_URL']! + widget.post.userAvatar,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.post.userName,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '32',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color.fromARGB(255, 47, 47, 47)),
                    child: Text(
                      'Subsribe',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  )
                ],
              );
            }),
            const SizedBox(height: 10),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  fadeInDuration: Duration.zero,
                  fadeOutDuration: Duration.zero,
                  imageUrl: dotenv.env['POST_URL']! + widget.post.image,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.post.title,
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        final state = context.read<AuthBloc>().state;
                        if (state is AuthSuccessful) {
                          context.read<PostBloc>().add(ToggleLike(
                              post: widget.post, userId: state.userModel.id));
                        }
                      },
                      child: Icon(
                        widget.post.isLiked!
                            ? Icons.favorite
                            : Icons.favorite_border_rounded,
                        size: 23,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 6),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.comment,
                        size: 23,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                    '${widget.post.likeCount} likes ~ ${widget.post.commentCount} coms'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
