import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/app/injector/injector.dart';
import 'package:todo/l10n/l10n.dart';
import 'package:todo/src/auth/bloc/auth_bloc.dart';
import 'package:todo/src/auth/view/landing_view.dart';
import 'package:todo/src/core/presentation/styles/app_themes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: MaterialApp(
        theme: AppTheme.ligthTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: const LandingView(),
      ),
    );
  }
}
