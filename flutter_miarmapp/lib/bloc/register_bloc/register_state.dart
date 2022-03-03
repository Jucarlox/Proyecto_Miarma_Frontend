part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final RegisterResponse loginResponse;

  const RegisterSuccessState(this.loginResponse);

  @override
  List<Object> get props => [loginResponse];
}

class LoginErrorState extends RegisterState {
  final String message;

  const LoginErrorState(this.message);

  @override
  List<Object> get props => [message];
}
