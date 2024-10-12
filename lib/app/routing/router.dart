import 'package:flutter/material.dart' show BuildContext;
import 'package:go_router/go_router.dart';

import '../pages/home/home_page.dart';

abstract class RoutePaths {
  static const String home = '/home';
}

abstract class AppRouter {
  static final GoRouter instance = GoRouter(
    initialLocation: RoutePaths.home,
    routes: [
      GoRoute(
        path: RoutePaths.home,
        builder: (BuildContext context, GoRouterState state) {
          return HomePage();
        },
        routes: const <RouteBase>[],
      ),
    ],
  );
}
