import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:todo/src/auth/view/email_auth_view.dart';
import 'package:todo/src/home/view/home_view.dart';
import 'package:todo/src/startup/startup_view.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(page: StartupView, initial: true),
    AutoRoute(page: EmailAuthView),
    AutoRoute(page: HomeView),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
