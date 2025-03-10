import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:xylo/data/models/post_model.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({super.key, required this.post});
  final PostModel post;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                    fadeInDuration: Duration.zero,
                    fadeOutDuration: Duration.zero,
                    imageUrl: dotenv.env['POST_URL']! + post.image),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              post.title,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {},
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
    );
  }
}
