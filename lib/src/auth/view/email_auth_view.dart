import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/app/router/router.dart';
import 'package:todo/src/auth/auth.dart';
import 'package:todo/src/core/domain/form_inputs/form_inputs.dart';
import 'package:todo/src/core/presentation/styles/app_colors.dart';

class EmailAuthView extends StatefulWidget {
  const EmailAuthView({super.key});

  @override
  State<EmailAuthView> createState() => _EmailAuthViewState();
}

class _EmailAuthViewState extends State<EmailAuthView> {
  late FocusNode emailFocusNode;
  late FocusNode passwordFocusNode;

  @override
  void initState() {
    super.initState();
    emailFocusNode = FocusNode()
      ..addListener(() {
        setState(() {});
      });
    passwordFocusNode = FocusNode()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
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
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return TextFormField(
                      autovalidateMode: state.showError
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      onChanged: (value) => context.read<AuthBloc>().add(
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
                      focusNode: emailFocusNode,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return TextFormField(
                      autovalidateMode: state.showError
                          ? AutovalidateMode.always
                          : AutovalidateMode.disabled,
                      onChanged: (value) => context.read<AuthBloc>().add(
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
                      focusNode: passwordFocusNode,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
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
                    style: TextButton.styleFrom(
                      primary: AppColors.accentColor,
                    ),
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                        ),
                        builder: (context) => const ResetPasswordView(),
                      );
                    },
                    child: const Text(
                      'Forgot Password?',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 54,
                        child: OutlinedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  RegisterWithEmailRequested(),
                                );
                          },
                          style: OutlinedButton.styleFrom(
                            primary: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            side: const BorderSide(
                              color: AppColors.primaryColor,
                            ),
                          ),
                          child: const Text(
                            'Register',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 54,
                        child: ElevatedButton(
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  SignInWithEmailRequested(),
                                );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 16,
                            ),
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
