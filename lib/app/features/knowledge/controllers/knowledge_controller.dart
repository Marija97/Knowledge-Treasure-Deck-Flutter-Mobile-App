import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/factoid.dart';
import 'knowledge_state.dart';

final knowledgeControllerProvider =
    AutoDisposeAsyncNotifierProvider<KnowledgeController, KnowledgeState>(
  () => KnowledgeController(),
);

class KnowledgeController extends AutoDisposeAsyncNotifier<KnowledgeState> {
  @override
  FutureOr<KnowledgeState> build() {

    return KnowledgeState([
      Factoid(question: 'Q1', correctAnswer: 'A1', obtained: true),
      Factoid(question: 'Q2', correctAnswer: 'A2', obtained: false),
      Factoid(question: 'Q3', correctAnswer: 'A3', obtained: false),
      Factoid(question: 'Q4', correctAnswer: 'A4', obtained: true),
      Factoid(question: 'Q5', correctAnswer: 'A5', obtained: true),
    ]); // Todo actual data
  }
}
