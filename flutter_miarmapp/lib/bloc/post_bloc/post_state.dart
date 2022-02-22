part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostFetched extends PostState {
  final List<PublicResponse> public;
  final String type;

  const PostFetched(this.public, this.type);

  @override
  List<Object> get props => [public];
}

class PostFetchError extends PostState {
  final String message;
  const PostFetchError(this.message);

  @override
  List<Object> get props => [message];
}
