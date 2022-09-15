import 'package:another_flushbar/flushbar_helper.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo/app/app.dart';
import 'package:todo/src/auth/auth.dart';
import 'package:todo/src/core/presentation/layout/layout.dart';
import 'package:todo/src/core/presentation/styles/styles.dart';

class LandingView extends StatelessWidget {
  const LandingView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (p, c) => p.googleLoginStatus != c.googleLoginStatus,
      listener: (context, state) {
        state.googleLoginStatus.maybeMap(
          loading: (_) => FlushbarHelper.createLoading(
            message: 'Loading...',
            linearProgressIndicator: const LinearProgressIndicator(
              color: AppColors.accentColor,
            ),
          ),
          success: (_) => context.router.replace(const HomeRoute()),
          failure: (f) => f.failure.maybeMap(
            serverError: (value) {
              if (value.message == 'cancelled') {
                return null;
              }
              return FlushbarHelper.createError(
                message: 'Something went wrong',
              ).show(context);
            },
            orElse: () => '',
          ),
          orElse: () => null,
        );
      },
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                const Text(
                  'Hello!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    letterSpacing: 1.5,
                  ),
                ),
                const Text(
                  'Welcome to todo app',
                  style: AppTypography.largeBodyTextStyle,
                ),
                Expanded(
                  flex: 6,
                  child: SvgPicture.asset(
                    isDarkMode
                        ? 'assets/images/landing_dark.svg'
                        : 'assets/images/landing.svg',
                    height: MediaQuery.of(context).size.height / 2,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          SignInWithGoogleRequested(),
                        );
                  },
                  icon: SvgPicture.asset(
                    'assets/icons/google.svg',
                    height: 16,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Continue with Google',
                  ),
                ),
                verticalSpaceTiny,
                OutlinedButton.icon(
                  onPressed: () {
                    context.router.push(
                      const EmailAuthRoute(),
                    );
                  },
                  icon: const Icon(
                    Icons.email_outlined,
                    size: 20,
                  ),
                  label: const Text(
                    'Continue with Email',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
