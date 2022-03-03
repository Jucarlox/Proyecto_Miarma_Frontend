import 'package:bloc/bloc.dart';
import 'package:flutter_miarmapp/models/PublicPost.dart';
import 'package:flutter_miarmapp/models/post_dto.dart';
import 'package:flutter_miarmapp/repository/post_repository/movie_repository.dart';
import 'package:equatable/equatable.dart';
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, BlocPublicacionesState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(BlocPublicacionesInitial()) {
    on<FetchPostWithType>(_postFetched);
    on<DoPublicacionEvent>(_doPublicacionEvent);
  }

  void _postFetched(
      FetchPostWithType event, Emitter<BlocPublicacionesState> emit) async {
    try {
      final post = await postRepository.fetchPublicPost(event.type);
      emit(PublicacionesFetched(post, event.type));
      return;
    } on Exception catch (e) {
      emit(PublicacionFetchError(e.toString()));
    }
  }

  void _doPublicacionEvent(
      DoPublicacionEvent event, Emitter<BlocPublicacionesState> emit) async {
    try {
      final loginResponse = await postRepository.createPublicacion(
          event.registerDto, event.imagePath);
      emit(PublicacionesSuccessState(loginResponse));
      return;
    } on Exception catch (e) {
      emit(PublicacionErrorState(e.toString()));
    }
  }
}
