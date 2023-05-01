import 'package:equatable/equatable.dart';

import '../../user_model.dart';

abstract class LoginSignupState extends Equatable {
  const LoginSignupState();

  @override
  List<Object> get props => [];
}

class LoginSignupInitial extends LoginSignupState {}

class LoginSignupLoading extends LoginSignupState {}

class LoginSignupSuccess extends LoginSignupState {
  final UserModel user;

  const LoginSignupSuccess({required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'LoginSignupSuccess { user: $user }';
}

class LoginSignupFailure extends LoginSignupState {
  final String error;

  const LoginSignupFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginSignupFailure { error: $error }';
}
