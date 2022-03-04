import 'package:bloc/bloc.dart';
import 'package:flutter_miarmapp/models/Profile.dart';
import 'package:flutter_miarmapp/models/PublicPost.dart';
import 'package:flutter_miarmapp/repository/post_repository/post_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_miarmapp/repository/profile.repository/profile_repository.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc(this.profileRepository) : super(ProfileInitial()) {
    on<FetchProfileWithType>(_visualizarProfileFetched);
  }

  void _visualizarProfileFetched(
      FetchProfileWithType event, Emitter<ProfileState> emit) async {
    try {
      final post = await profileRepository.fetchVisualizarPerfil(event.type);
      emit(ProfileFetched(post, event.type));
      return;
    } on Exception catch (e) {
      emit(ProfileFetchError(e.toString()));
    }
  }
}
