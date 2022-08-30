part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.googleLoginStatus = const Status.initial(),
    this.emailLoginStatus = const Status.initial(),
    this.emailRegisterStatus = const Status.initial(),
    this.resetPasswordStatus = const Status.initial(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.user = User.empty,
  });

  final Status googleLoginStatus;
  final Status emailLoginStatus;
  final Status emailRegisterStatus;
  final Status resetPasswordStatus;
  final Email email;
  final Password password;
  final User user;

  AuthState copyWith({
    Status? googleLoginStatus,
    Status? emailLoginStatus,
    Status? emailRegisterStatus,
    Status? resetPasswordStatus,
    Email? email,
    Password? password,
    User? user,
  }) {
    return AuthState(
      googleLoginStatus: googleLoginStatus ?? this.googleLoginStatus,
      emailLoginStatus: emailLoginStatus ?? this.emailLoginStatus,
      emailRegisterStatus: emailRegisterStatus ?? this.emailRegisterStatus,
      resetPasswordStatus: resetPasswordStatus ?? this.resetPasswordStatus,
      email: email ?? this.email,
      password: password ?? this.password,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props {
    return [
      googleLoginStatus,
      emailLoginStatus,
      emailRegisterStatus,
      resetPasswordStatus,
      email,
      password,
      user,
    ];
  }
}
