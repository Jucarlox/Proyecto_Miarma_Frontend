part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostSuccessState extends PostState {
  final PublicResponse postResponse;

  const PostSuccessState(this.postResponse);

  @override
  List<Object> get props => [postResponse];
}

class PostErrorState extends PostState {
  final String message;

  const PostErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class PostFetched extends PostState {
  final List<PublicResponse> posts;
  final String type;

  const PostFetched(this.posts, this.type);

  @override
  List<Object> get props => [posts];
}

class PostFetchError extends PostState {
  final String message;
  const PostFetchError(this.message);

  @override
  List<Object> get props => [message];
}
