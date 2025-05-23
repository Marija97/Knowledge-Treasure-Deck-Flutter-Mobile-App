import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:know_flow/app/features/splash/controller/splash_state.dart';

import '../../../data/knowledge_repository/knowledge_repository.dart';
import '../../../services/storage/storage_service.dart';

final splashControllerProvider =
    AsyncNotifierProvider.autoDispose<SplashController, SplashState>(
  () => SplashController(),
);

class SplashController extends AutoDisposeAsyncNotifier<SplashState> {
  final shouldRefreshDatabase = false;

  @override
  FutureOr<SplashState> build() async {
    await ref.read(storageServiceProvider).init();
    if (shouldRefreshDatabase) {
      // await ref.read(knowledgeRepositoryProvider).clear();

      // reload the data
      final data = await rootBundle.loadString('assets/quiz_data/test.json');
      await ref.read(knowledgeRepositoryProvider).setupInitialKnowledge(data);
    }

    return SplashState();
  }
}
