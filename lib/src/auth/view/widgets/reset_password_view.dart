import 'dart:developer';

import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/app.dart';
import 'package:todo/src/auth/auth.dart';
import 'package:todo/src/core/domain/form_inputs/form_inputs.dart';
import 'package:todo/src/core/presentation/layout/spacing.dart';
import 'package:todo/src/core/presentation/styles/styles.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({
    super.key,
  });

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
            const Text(
              'Reset Password',
              style: TextStyle(
                fontSize: 20,
              ),
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
            SizedBox(
              height: 54,
              child: ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        ResetPasswordRequested(),
                      );
                },
                child: const Text(
                  'Send Reset Email',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
