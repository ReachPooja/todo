import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo/app/app.dart';
import 'package:todo/l10n/l10n.dart';
import 'package:todo/src/auth/auth.dart';
import 'package:todo/src/core/presentation/styles/styles.dart';
import 'package:todo/src/theme/cubit/theme_cubit.dart';

class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MaterialApp.router(
            themeMode: context.watch<ThemeCubit>().state,
            theme: AppTheme.ligthTheme,
            darkTheme: AppTheme.darkTheme,
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            routerDelegate: AutoRouterDelegate(_appRouter),
            routeInformationParser: _appRouter.defaultRouteParser(),
          );
        },
      ),
    );
  }
}
