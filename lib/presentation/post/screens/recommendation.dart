import 'package:flutter/widgets.dart';
import 'package:xylo/presentation/profile/widgets/post_widget.dart';

class Recommendation extends StatelessWidget {
  const Recommendation({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemCount: ,itemBuilder: (context,index){
      return PostWidget(post: post);
    });
  }
}
