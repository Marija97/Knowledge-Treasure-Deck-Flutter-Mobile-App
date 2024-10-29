import 'package:flutter/material.dart' show BuildContext;
import 'package:go_router/go_router.dart';

import '../features/knowledge/view/knowledge_overview_page.dart';
import '../features/quiz/view/quiz_page.dart';
import '../features/splash/view/splash_page.dart';

abstract class RoutePaths {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String quiz = '/quiz';
}

abstract class AppRouter {
  static final GoRouter instance = GoRouter(
    initialLocation: RoutePaths.splash,
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        builder: (BuildContext context, GoRouterState state) {
          return SplashPage();
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        path: RoutePaths.home,
        builder: (BuildContext context, GoRouterState state) {
          return KnowledgeOverviewPage();
        },
        routes: const <RouteBase>[],
      ),
      GoRoute(
        path: RoutePaths.quiz,
        builder: (BuildContext context, GoRouterState state) {
          return QuizPage(state.extra as String);
        },
        routes: const <RouteBase>[],
      ),
    ],
  );
}
