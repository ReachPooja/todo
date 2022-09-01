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
    Startup.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const Startup());
    },
    EmailAuthRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const EmailAuthView());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(Startup.name, path: '/'),
        RouteConfig(EmailAuthRoute.name, path: '/email-auth-view')
      ];
}

/// generated route for
/// [Startup]
class Startup extends PageRouteInfo<void> {
  const Startup() : super(Startup.name, path: '/');

  static const String name = 'Startup';
}

/// generated route for
/// [EmailAuthView]
class EmailAuthRoute extends PageRouteInfo<void> {
  const EmailAuthRoute() : super(EmailAuthRoute.name, path: '/email-auth-view');

  static const String name = 'EmailAuthRoute';
}
