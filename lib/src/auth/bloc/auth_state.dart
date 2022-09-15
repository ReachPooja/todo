part of 'auth_bloc.dart';

class AuthState extends Equatable {
  const AuthState({
    this.authCheckStatus = const Status.initial(),
    this.googleLoginStatus = const Status.initial(),
    this.emailLoginStatus = const Status.initial(),
    this.emailRegisterStatus = const Status.initial(),
    this.resetPasswordStatus = const Status.initial(),
    this.logoutStatus = const Status.initial(),
    this.email = const Email.pure(),
    this.resetEmail = const Email.pure(),
    this.password = const Password.pure(),
    this.user = User.empty,
    this.showError = false,
    this.showPassword = false,
    this.isUserAuthenticated,
  });

  final Status authCheckStatus;
  final Status googleLoginStatus;
  final Status emailLoginStatus;
  final Status emailRegisterStatus;
  final Status resetPasswordStatus;
  final Status logoutStatus;
  final Email email;
  final Email resetEmail;
  final Password password;
  final User user;
  final bool showError;
  final bool showPassword;
  final bool? isUserAuthenticated;

  @override
  List<Object?> get props {
    return [
      authCheckStatus,
      googleLoginStatus,
      emailLoginStatus,
      emailRegisterStatus,
      resetPasswordStatus,
      logoutStatus,
      email,
      resetEmail,
      password,
      user,
      showError,
      showPassword,
      isUserAuthenticated,
    ];
  }

  AuthState copyWith({
    Status? authCheckStatus,
    Status? googleLoginStatus,
    Status? emailLoginStatus,
    Status? emailRegisterStatus,
    Status? resetPasswordStatus,
    Status? logoutStatus,
    Email? email,
    Email? resetEmail,
    Password? password,
    User? user,
    bool? showError,
    bool? showPassword,
    bool? isUserAuthenticated,
  }) {
    return AuthState(
      authCheckStatus: authCheckStatus ?? this.authCheckStatus,
      googleLoginStatus: googleLoginStatus ?? this.googleLoginStatus,
      emailLoginStatus: emailLoginStatus ?? this.emailLoginStatus,
      emailRegisterStatus: emailRegisterStatus ?? this.emailRegisterStatus,
      resetPasswordStatus: resetPasswordStatus ?? this.resetPasswordStatus,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      email: email ?? this.email,
      resetEmail: resetEmail ?? this.resetEmail,
      password: password ?? this.password,
      user: user ?? this.user,
      showError: showError ?? this.showError,
      showPassword: showPassword ?? this.showPassword,
      isUserAuthenticated: isUserAuthenticated ?? this.isUserAuthenticated,
    );
  }

  @override
  String toString() {
    return 'AuthState(authCheckStatus: $authCheckStatus, googleLoginStatus:'
        ' $googleLoginStatus, emailLoginStatus: $emailLoginStatus,'
        ' emailRegisterStatus: $emailRegisterStatus, resetPasswordStatus: '
        '$resetPasswordStatus, logoutStatus: $logoutStatus, email: $email, '
        'resetEmail: $resetEmail, password: $password, user: $user, showError: '
        '$showError, showPassword: $showPassword, isUserAuthenticated: '
        '$isUserAuthenticated)';
  }
}
