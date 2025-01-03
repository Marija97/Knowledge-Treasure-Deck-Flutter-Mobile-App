import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/router.dart';
import '../controller/splash_controller.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  Widget build(BuildContext context) {
    ref.listen(splashControllerProvider, (previous, next) {
      Future.delayed(const Duration(seconds: 1), () {
        /// Delay routing 1 second, so that the animation is played
        GoRouter.of(context).go(RoutePaths.home);
      });
    });

    return Scaffold(
      body: Center(
        child: Hero(
          tag: 'splash',
          child: Image.asset(
            './assets/images/logos/owl_orange.png',
            height: 100,
          ),
        ),
      ),
    );
  }
}
