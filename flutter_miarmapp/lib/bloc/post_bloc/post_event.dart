part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class FetchPostWithType extends PostEvent {
  final String type;

  const FetchPostWithType(this.type);

  @override
  List<Object> get props => [type];
}

class DoPostEvent extends PostEvent {
  final PostDto postDto;
  final String imagePath;

  const DoPostEvent(this.postDto, this.imagePath);
}
