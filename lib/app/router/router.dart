import 'package:auto_route/auto_route.dart';
import 'package:todo/src/auth/view/landing_view.dart';

part 'router.gr.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'View,Route',
  routes: <AutoRoute>[
    AutoRoute(page: LandingView, initial: true),
  ],
)
// extend the generated private router
class AppRouter extends _$AppRouter {}
