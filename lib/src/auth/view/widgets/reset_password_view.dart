import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/auth/auth.dart';
import 'package:todo/src/core/domain/form_inputs/form_inputs.dart';
import 'package:todo/src/core/presentation/styles/styles.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Reset Password',
                  style: AppTypography.mediumTitleTextStyle,
                ),
                CloseButton(),
              ],
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                  ),
                  child: TextFormField(
                    initialValue:
                        state.email.value.isEmpty ? null : state.email.value,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value) => context.read<AuthBloc>().add(
                          ResetEmailChanged(email: value),
                        ),
                    validator: (value) {
                      if (state.resetEmail.error ==
                          EmailValidationError.empty) {
                        return 'Enter an email';
                      }
                      if (state.resetEmail.error ==
                          EmailValidationError.invalid) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                );
              },
            ),
            ElevatedButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                context.read<AuthBloc>().add(
                      ResetPasswordRequested(),
                    );
              },
              child: const Text(
                'Send Reset Email',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
