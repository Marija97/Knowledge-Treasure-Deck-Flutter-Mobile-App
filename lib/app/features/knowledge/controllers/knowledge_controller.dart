import 'package:ash/app/services/storage/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/knowledge_repository/knowledge_repository.dart';
import '../../../data/models/factoid.dart';
import 'knowledge_state.dart';

final knowledgeControllerProvider =
    NotifierProvider<KnowledgeController, KnowledgeState>(
  () => KnowledgeController(),
);

class KnowledgeController extends Notifier<KnowledgeState> {
  // final fetchedKnowledge = <Factoid>[];

  void databaseFillUpTest() {
    final knowledge = [
      Factoid(question: 'Q01', correctAnswer: 'A1', obtained: true),
      Factoid(question: 'Q02', correctAnswer: 'A2', obtained: false),
      Factoid(question: 'Q03', correctAnswer: 'A3', obtained: false),
      Factoid(question: 'Q04', correctAnswer: 'A4', obtained: true),
      Factoid(question: 'Q05', correctAnswer: 'A5', obtained: true),
    ];
    ref.read(knowledgeRepositoryProvider).setupInitialKnowledge(knowledge);
  }

  void readDatabaseTest() {
    final units = ref.read(knowledgeRepositoryProvider).getKnowledge();
    state = KnowledgeState(units);
  }

  void clearDatabaseTest() {
    ref.read(knowledgeRepositoryProvider).clear();
  }

  @override
  KnowledgeState build() {
    ref.read(storageServiceProvider).init().whenComplete(() {
      state = KnowledgeState([
        Factoid(question: 'The storage is initialized.', correctAnswer: 'A1'),
      ]);
    });
    return KnowledgeState([
      Factoid(question: 'Just the sad default', correctAnswer: 'A1'),
    ]);
  }
}
