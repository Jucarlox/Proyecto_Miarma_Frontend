part of 'post_bloc.dart';

abstract class BlocPublicacionesState extends Equatable {
  const BlocPublicacionesState();

  @override
  List<Object> get props => [];
}

class BlocPublicacionesInitial extends BlocPublicacionesState {}

class PublicacionesLoading extends BlocPublicacionesState {}

class PublicacionesSuccessState extends BlocPublicacionesState {
  final PublicResponse loginResponse;

  const PublicacionesSuccessState(this.loginResponse);

  @override
  List<Object> get props => [loginResponse];
}

class PublicacionErrorState extends BlocPublicacionesState {
  final String message;

  const PublicacionErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class PublicacionesFetched extends BlocPublicacionesState {
  final List<PublicResponse> publicaciones;
  final String type;

  const PublicacionesFetched(this.publicaciones, this.type);

  @override
  List<Object> get props => [publicaciones];
}

class PublicacionFetchError extends BlocPublicacionesState {
  final String message;
  const PublicacionFetchError(this.message);

  @override
  List<Object> get props => [message];
}
