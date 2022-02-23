part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchProfileWithType extends ProfileEvent {
  final String type;

  const FetchProfileWithType(this.type);

  @override
  List<Object> get props => [type];
}
