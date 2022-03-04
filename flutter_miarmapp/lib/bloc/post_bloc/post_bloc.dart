import 'package:bloc/bloc.dart';
import 'package:flutter_miarmapp/models/PublicPost.dart';
import 'package:flutter_miarmapp/models/post_dto.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';
import 'package:equatable/equatable.dart';
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(PostInitial()) {
    on<FetchPostWithType>(_postFetched);
    on<DoPostEvent>(_doPostEvent);
  }

  void _postFetched(FetchPostWithType event, Emitter<PostState> emit) async {
    try {
      final post = await postRepository.fetchPublicPost(event.type);
      emit(PostFetched(post, event.type));
      return;
    } on Exception catch (e) {
      emit(PostFetchError(e.toString()));
    }
  }

  void _doPostEvent(DoPostEvent event, Emitter<PostState> emit) async {
    try {
      final postResponse =
          await postRepository.createPost(event.postDto, event.imagePath);
      emit(PostSuccessState(postResponse));
      return;
    } on Exception catch (e) {
      emit(PostErrorState(e.toString()));
    }
  }
}
