import 'package:ash/app/features/knowledge/view/knowledge_overview_page.dart';
import 'package:ash/app/features/quiz/view/quiz_page.dart';
import 'package:flutter/material.dart' show BuildContext;
import 'package:go_router/go_router.dart';

abstract class RoutePaths {
  static const String home = '/home';
  static const String quiz = '/quiz';
}

abstract class AppRouter {
  static final GoRouter instance = GoRouter(
    initialLocation: RoutePaths.home,
    routes: [
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
