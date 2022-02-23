part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileFetched extends ProfileState {
  final VisualizarPerfilResponse public;
  final String type;

  const ProfileFetched(this.public, this.type);

  @override
  List<Object> get props => [public];
}

class ProfileFetchError extends ProfileState {
  final String message;
  const ProfileFetchError(this.message);

  @override
  List<Object> get props => [message];
}
