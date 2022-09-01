import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/src/auth/bloc/auth_bloc.dart';
import 'package:todo/src/auth/view/landing_view.dart';
import 'package:todo/src/home/view/home_view.dart';
import 'package:todo/src/startup/widgets/splash.dart';

class Startup extends StatelessWidget {
  const Startup({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.isUserAuthenticated == null) {
          return const Splash();
        } else if (state.isUserAuthenticated!) {
          return const HomeView();
        } else {
          return const LandingView();
        }
      },
    );
  }
}
