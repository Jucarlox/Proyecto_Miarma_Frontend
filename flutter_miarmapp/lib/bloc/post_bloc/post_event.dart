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

class DoPublicacionEvent extends PostEvent {
  final PostDto registerDto;
  final String imagePath;

  const DoPublicacionEvent(this.registerDto, this.imagePath);
}
