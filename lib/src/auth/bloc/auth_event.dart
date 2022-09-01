part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class SignInWithGoogleRequested extends AuthEvent {}

class EmailChanged extends AuthEvent {
  const EmailChanged({
    required this.email,
  });
  final String email;
  @override
  List<Object> get props => [email];
}

class ResetEmailChanged extends AuthEvent {
  const ResetEmailChanged({
    required this.email,
  });
  final String email;
  @override
  List<Object> get props => [email];
}

class PasswordChanged extends AuthEvent {
  const PasswordChanged({
    required this.password,
  });
  final String password;
  @override
  List<Object> get props => [password];
}

class ShowPasswordChanged extends AuthEvent {}

class RegisterWithEmailRequested extends AuthEvent {}

class SignInWithEmailRequested extends AuthEvent {}

class ResetPasswordRequested extends AuthEvent {}
