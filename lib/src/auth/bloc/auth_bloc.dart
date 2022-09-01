import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:todo/src/auth/repository/i_auth_repository.dart';
import 'package:todo/src/core/domain/failures/failures.dart';
import 'package:todo/src/core/domain/form_inputs/email.dart';
import 'package:todo/src/core/domain/form_inputs/password.dart';
import 'package:todo/src/core/domain/status/status.dart';
import 'package:todo/src/user/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this._authRepository) : super(const AuthState()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<SignInWithGoogleRequested>(_onSignInWithGoogleRequested);
    on<EmailChanged>(_onEmailChanged);
    on<ResetEmailChanged>(_onResetEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ShowPasswordChanged>(_onShowPasswordChanged);
    on<RegisterWithEmailRequested>(_onRegisterWithEmailRequested);
    on<SignInWithEmailRequested>(_onSignInWithEmailRequested);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
  }

  final IAuthRepository _authRepository;

  void _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) {
    final result = _authRepository.isUserAutheticated();

    emit(
      result.fold(
        () => state.copyWith(
          isUserAuthenticated: false,
        ),
        (user) => state.copyWith(
          user: user,
          isUserAuthenticated: true,
        ),
      ),
    );
  }

  Future<void> _onSignInWithGoogleRequested(
    SignInWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        googleLoginStatus: const Status.loading(),
      ),
    );
    final result = await _authRepository.loginWithGoogle();
    emit(
      result.fold(
        (f) => state.copyWith(
          googleLoginStatus: Status.failure(f),
        ),
        (data) => state.copyWith(
          googleLoginStatus: const Status.success(),
          user: data,
        ),
      ),
    );
  }

  void _onEmailChanged(
    EmailChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        email: Email.dirty(event.email),
      ),
    );
  }

  void _onResetEmailChanged(
    ResetEmailChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        resetEmail: Email.dirty(event.email),
      ),
    );
  }

  void _onPasswordChanged(
    PasswordChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        password: Password.dirty(event.password),
      ),
    );
  }

  void _onShowPasswordChanged(
    ShowPasswordChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        showPassword: !state.showPassword,
      ),
    );
  }

  Future<void> _onRegisterWithEmailRequested(
    RegisterWithEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    final isFormValid = Formz.validate([state.email, state.password]).isValid;
    if (isFormValid) {
      emit(
        state.copyWith(
          emailRegisterStatus: const Status.loading(),
        ),
      );

      final result = await _authRepository.registerWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );

      emit(
        result.fold(
          (f) => state.copyWith(
            emailRegisterStatus: Status.failure(f),
            showError: false,
          ),
          (data) => state.copyWith(
            emailRegisterStatus: const Status.success(),
            user: data,
            showError: false,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          showError: true,
        ),
      );
    }
  }

  Future<void> _onSignInWithEmailRequested(
    SignInWithEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    final isFormValid = Formz.validate([state.email, state.password]).isValid;
    if (isFormValid) {
      emit(
        state.copyWith(
          emailLoginStatus: const Status.loading(),
        ),
      );
      final result = await _authRepository.loginWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );

      emit(
        result.fold(
          (f) => state.copyWith(
            emailLoginStatus: Status.failure(f),
            showError: false,
          ),
          (data) => state.copyWith(
            emailLoginStatus: const Status.success(),
            user: data,
            showError: false,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          showError: true,
        ),
      );
    }
  }

  Future<void> _onResetPasswordRequested(
    ResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(
      state.copyWith(
        resetEmail: state.email,
      ),
    );

    final isEmailValid = state.resetEmail.valid;
    if (isEmailValid) {
      emit(
        state.copyWith(
          resetPasswordStatus: const Status.loading(),
        ),
      );
      final result =
          await _authRepository.resetPassword(state.resetEmail.value);

      emit(
        result.fold(
          (f) => state.copyWith(
            resetPasswordStatus: Status.failure(f),
          ),
          (r) => state.copyWith(
            resetPasswordStatus: const Status.success(),
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          resetPasswordStatus: const Status.failure(
            Failure.localError(
              message: 'Invalid email',
            ),
          ),
        ),
      );
    }
  }
}
