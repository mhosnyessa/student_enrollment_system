import 'package:equatable/equatable.dart';

abstract class LoginSignupEvent extends Equatable {
  const LoginSignupEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginSignupEvent {
  final String email;
  final String password;

  const LoginButtonPressed({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'LoginButtonPressed { email: $email }';
}

class SignupButtonPressed extends LoginSignupEvent {
  final String name;
  final String email;
  final String password;

  const SignupButtonPressed({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [ name, email, password];

  @override
  String toString() => 'SignupButtonPressed { email: $email , name: $name }';
}
