import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:xylo/data/models/post_model.dart';
import 'package:xylo/domain/use_cases/post_count_update.dart';
import 'package:xylo/domain/use_cases/save_image_todb.dart';
import 'package:xylo/domain/use_cases/save_post_todb.dart';
import 'package:xylo/logic/create_post/create_post_event.dart';
import 'package:xylo/logic/create_post/create_post_state.dart';

class CreatePostBloc extends Bloc<CreatePostEvent, CreatePostState> {
  SaveImageTodb saveImageTodb;
  SavePostTodb savePostTodb;
  PostCountUpdate postCountUpdate;
  CreatePostBloc(
      {required this.postCountUpdate,
      required this.saveImageTodb,
      required this.savePostTodb})
      : super(CreatePostInitial()) {
    on<CreateRequest>((event, emit) async {
      try {
        emit(CreatePostLoading());
        final file = event.file;
        String? url;
        final uuid = Uuid();
        String postId = uuid.v4();
        if (file != null) {
          url = await saveImageTodb.call(file, event.userId, postId);
        }
        final post = PostModel(
            createdAt: DateTime.now(),
            usedId: event.userId,
            id: postId,
            title: event.title,
            isAnonymous: event.isAnonymous,
            image: url ?? '');
        await savePostTodb(post);
        await postCountUpdate(event.user);
        emit(CreatePostSuccessful(id: event.userId));
      } catch (e) {
        emit(CreatePostError(message: e.toString()));
      }
    });
  }
}
