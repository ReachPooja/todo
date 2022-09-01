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
    on<ShowPasswordChanged>(_onShowPasswordChanged);
    on<RegisterWithEmailRequested>(_onRegisterWithEmailRequested);
    on<SignInWithEmailRequested>(_onSignInWithEmailRequested);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
  }

  final IAuthRepository _authRepository;

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
    final isEmailValid = state.email.valid;
    if (isEmailValid) {
      final result = await _authRepository.resetPassword(state.email.value);

      emit(
        result.fold(
          () => state.copyWith(
            resetPasswordStatus: const Status.success(),
            showError: false,
          ),
          (f) => state.copyWith(
            resetPasswordStatus: Status.failure(f),
            showError: false,
          ),
        ),
      );
    } else {
      emit(
        state.copyWith(
          showError: true,
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
