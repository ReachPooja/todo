import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/router/router.dart';
import 'package:todo/src/auth/auth.dart';
import 'package:todo/src/core/domain/form_inputs/form_inputs.dart';
import 'package:todo/src/core/presentation/layout/layout.dart';
import 'package:todo/src/core/presentation/styles/styles.dart';

class EmailAuthView extends StatelessWidget {
  const EmailAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (p, c) =>
                p.emailRegisterStatus != c.emailRegisterStatus,
            listener: (context, state) {
              state.emailRegisterStatus.maybeMap(
                loading: (_) {
                  context.router.popUntil(
                    (route) => route.settings.name == EmailAuthRoute.name,
                  );
                  FlushbarHelper.createLoading(
                    message: 'Register in process..',
                    linearProgressIndicator: const LinearProgressIndicator(
                      color: AppColors.accentColor,
                    ),
                  ).show(context);
                },
                success: (_) {
                  context.router.popUntil(
                    (route) => route.settings.name == EmailAuthRoute.name,
                  );
                  context.router.pushAndPopUntil(
                    const HomeRoute(),
                    predicate: (route) =>
                        route.settings.name == StartupRoute.name,
                  );
                },
                failure: (f) {
                  context.router.popUntil(
                    (route) => route.settings.name == EmailAuthRoute.name,
                  );
                  FlushbarHelper.createError(
                    message: f.failure.maybeMap(
                      unexpected: (v) => 'Something went wrong',
                      serverError: (v) {
                        if (v.message == null) {
                          return 'Something went wrong';
                        }
                        if (v.message! == 'email-already-in-use') {
                          return 'Already have an account';
                        }

                        return v.message.toString();
                      },
                      orElse: () => '',
                    ),
                  ).show(context);
                },
                orElse: () => null,
              );
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (p, c) => p.emailLoginStatus != c.emailLoginStatus,
            listener: (context, state) {
              state.emailLoginStatus.maybeMap(
                loading: (_) {
                  context.router.popUntil(
                    (route) => route.settings.name == EmailAuthRoute.name,
                  );
                  FlushbarHelper.createLoading(
                    message: 'Logging in..',
                    linearProgressIndicator: const LinearProgressIndicator(
                      color: AppColors.accentColor,
                    ),
                  ).show(context);
                },
                success: (_) {
                  context.router.popUntil(
                    (route) => route.settings.name == EmailAuthRoute.name,
                  );
                  context.router.pushAndPopUntil(
                    const HomeRoute(),
                    predicate: (route) =>
                        route.settings.name == StartupRoute.name,
                  );
                },
                failure: (f) {
                  context.router.popUntil(
                    (route) => route.settings.name == EmailAuthRoute.name,
                  );
                  FlushbarHelper.createError(
                    message: f.failure.maybeMap(
                      unexpected: (v) => 'Something went wrong',
                      serverError: (v) {
                        if (v.message == null) {
                          return 'Something went wrong';
                        }
                        if (v.message! == 'user-not-found') {
                          return 'No user found with this email';
                        }

                        return v.message.toString();
                      },
                      orElse: () => 'Something went wrong',
                    ),
                  ).show(context);
                },
                orElse: () => null,
              );
            },
          ),
          BlocListener<AuthBloc, AuthState>(
            listenWhen: (p, c) =>
                p.resetPasswordStatus != c.resetPasswordStatus,
            listener: (context, state) {
              state.resetPasswordStatus.maybeMap(
                loading: (_) {
                  context.router.popUntil(
                    (route) => route.settings.name == EmailAuthRoute.name,
                  );

                  FlushbarHelper.createLoading(
                    message: 'Sending Reset Email..',
                    linearProgressIndicator: const LinearProgressIndicator(
                      color: AppColors.accentColor,
                    ),
                  ).show(context);
                },
                success: (_) {
                  context.router.popUntil(
                    (route) => route.settings.name == EmailAuthRoute.name,
                  );

                  FlushbarHelper.createSuccess(
                    message: 'Reset password mail sent!',
                  ).show(context);
                },
                failure: (f) {
                  context.router.popUntil(
                    (route) => route.settings.name == EmailAuthRoute.name,
                  );
                  FlushbarHelper.createError(
                    message: f.failure.maybeMap(
                      unexpected: (v) => 'Something went wrong',
                      serverError: (v) {
                        if (v.message == null) {
                          return 'Something went wrong';
                        }
                        if (v.message! == 'user-not-found') {
                          return 'No account found with the given email';
                        }

                        return v.message.toString();
                      },
                      orElse: () => '',
                    ),
                  ).show(context);
                },
                orElse: () => null,
              );
            },
          ),
        ],
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                const Text(
                  'Continue with Email',
                  style: AppTypography.mediumTitleTextStyle,
                ),
                verticalSpaceRegular,
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return TextFormField(
                      autovalidateMode: state.showError
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      onChanged: (value) => authBloc.add(
                        EmailChanged(email: value),
                      ),
                      validator: (value) {
                        if (state.email.error == EmailValidationError.empty) {
                          return 'Enter an email';
                        }
                        if (state.email.error == EmailValidationError.invalid) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                    );
                  },
                ),
                verticalSpaceRegular,
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return TextFormField(
                      autovalidateMode: state.showError
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      onChanged: (value) => authBloc.add(
                        PasswordChanged(password: value),
                      ),
                      validator: (value) {
                        if (state.password.error ==
                            PasswordValidationError.empty) {
                          return 'Enter a password';
                        }
                        if (state.password.error ==
                            PasswordValidationError.short) {
                          return 'Password should be at least '
                              '8 characters long';
                        }
                        if (state.password.error ==
                            PasswordValidationError.capitalLetter) {
                          return 'Password should have a capital letter';
                        }
                        if (state.password.error ==
                            PasswordValidationError.number) {
                          return 'Password should have a number';
                        }
                        if (state.password.error ==
                            PasswordValidationError.invalid) {
                          return 'Password should have a special characters';
                        }
                        return null;
                      },
                      obscureText: !state.showPassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            authBloc.add(
                              ShowPasswordChanged(),
                            );
                          },
                          icon: Icon(
                            state.showPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        shape: Constants.bottomSheetRadius,
                        builder: (context) => const ResetPasswordView(),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                    ),
                  ),
                ),
                verticalSpaceRegular,
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 54,
                        child: OutlinedButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            authBloc.add(
                              RegisterWithEmailRequested(),
                            );
                          },
                          child: const Text(
                            'Register',
                            style: AppTypography.mediumBodyTextStyle,
                          ),
                        ),
                      ),
                    ),
                    horizontalSpaceRegular,
                    Expanded(
                      child: SizedBox(
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            authBloc.add(
                              SignInWithEmailRequested(),
                            );
                          },
                          child: const Text(
                            'Login',
                            style: AppTypography.mediumBodyTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
