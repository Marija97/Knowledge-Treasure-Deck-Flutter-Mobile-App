import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'knowledge_state.dart';

final knowledgeControllerProvider =
    AutoDisposeAsyncNotifierProvider<KnowledgeController, KnowledgeState>(
  () => KnowledgeController(),
);

class KnowledgeController extends AutoDisposeAsyncNotifier<KnowledgeState> {
  @override
  FutureOr<KnowledgeState> build() {
    return KnowledgeState(['test 1', 'test 2']); // Todo actual data
  }
}
