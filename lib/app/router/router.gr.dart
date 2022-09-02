// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    StartupRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const StartupView());
    },
    EmailAuthRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmailAuthView());
    },
    HomeRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const HomeView());
    },
    CreateTodoRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const CreateTodoView());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(StartupRoute.name, path: '/'),
        RouteConfig(EmailAuthRoute.name, path: '/email-auth-view'),
        RouteConfig(HomeRoute.name, path: '/home-view'),
        RouteConfig(CreateTodoRoute.name, path: '/create-todo-view')
      ];
}

/// generated route for
/// [StartupView]
class StartupRoute extends PageRouteInfo<void> {
  const StartupRoute() : super(StartupRoute.name, path: '/');

  static const String name = 'StartupRoute';
}

/// generated route for
/// [EmailAuthView]
class EmailAuthRoute extends PageRouteInfo<void> {
  const EmailAuthRoute() : super(EmailAuthRoute.name, path: '/email-auth-view');

  static const String name = 'EmailAuthRoute';
}

/// generated route for
/// [HomeView]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/home-view');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [CreateTodoView]
class CreateTodoRoute extends PageRouteInfo<void> {
  const CreateTodoRoute()
      : super(CreateTodoRoute.name, path: '/create-todo-view');

  static const String name = 'CreateTodoRoute';
}
