import 'package:auto_route/auto_route.dart';
import 'package:todo/src/auth/view/email_auth_view.dart';
import 'package:todo/src/startup/startup.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(page: Startup, initial: true),
    AutoRoute(page: EmailAuthView),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
