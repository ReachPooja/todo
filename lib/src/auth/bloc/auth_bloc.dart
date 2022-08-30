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
    on<SignInWithGoogleRequested>(_onSignInWithGoogleRequested);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<RegisterWithEmailRequested>(_onRegisterWithEmailRequested);
    on<SignInWithEmailRequested>(_onSignInWithEmailRequested);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
  }

  final IAuthRepository _authRepository;

  Future<void> _onSignInWithGoogleRequested(
    SignInWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _authRepository.loginWithGoogle();
    result.fold(
      (f) => emit(
        state.copyWith(
          googleLoginStatus: Status.failure(f),
        ),
      ),
      (data) => emit(
        state.copyWith(
          googleLoginStatus: const Status.success(),
          user: data,
        ),
      ),
    );
  }

  FutureOr<void> _onEmailChanged(
    EmailChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        email: Email.dirty(event.email),
      ),
    );
  }

  FutureOr<void> _onPasswordChanged(
    PasswordChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(
      state.copyWith(
        password: Password.dirty(event.password),
      ),
    );
  }

  Future<void> _onRegisterWithEmailRequested(
    RegisterWithEmailRequested event,
    Emitter<AuthState> emit,
  ) async {
    final isFormValid = Formz.validate([state.email, state.password]).isValid;
    if (isFormValid) {
      final result = await _authRepository.registerWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );

      result.fold(
        (f) => emit(
          state.copyWith(
            emailRegisterStatus: Status.failure(f),
          ),
        ),
        (data) => emit(
          state.copyWith(
            emailRegisterStatus: const Status.success(),
            user: data,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          emailRegisterStatus: const Status.failure(
            Failure.localError(message: 'Invald input'),
          ),
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
      final result = await _authRepository.loginWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );

      result.fold(
        (f) => emit(
          state.copyWith(
            emailLoginStatus: Status.failure(f),
          ),
        ),
        (data) => emit(
          state.copyWith(
            emailLoginStatus: const Status.success(),
            user: data,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          emailLoginStatus: const Status.failure(
            Failure.localError(message: 'Invald input'),
          ),
        ),
      );
    }
  }

  Future<void> _onResetPasswordRequested(
    ResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    final isEmailValid = state.email.valid;
    if (isEmailValid) {
      final result = await _authRepository.resetPassword(state.email.value);

      result.fold(
        () => emit(
          state.copyWith(
            resetPasswordStatus: const Status.success(),
          ),
        ),
        (f) => emit(
          state.copyWith(
            resetPasswordStatus: Status.failure(f),
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          resetPasswordStatus: const Status.failure(
            Failure.localError(
              message: 'Please provide a valid email address',
            ),
          ),
        ),
      );
    }
  }
}
