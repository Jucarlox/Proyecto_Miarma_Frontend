import 'package:bloc/bloc.dart';
import 'package:flutter_miarmapp/models/PublicPost.dart';
import 'package:flutter_miarmapp/repository/post_repository/movie_repository.dart';
import 'package:equatable/equatable.dart';
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(PostInitial()) {
    on<FetchPostWithType>(_postFetched);
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
}
