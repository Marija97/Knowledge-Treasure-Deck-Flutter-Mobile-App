import 'dart:convert';

import 'package:ash/app/services/storage/storage_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/knowledge_repository/knowledge_repository.dart';
import '../../../data/models/factoid.dart';
import 'knowledge_state.dart';

final knowledgeControllerProvider =
    NotifierProvider<KnowledgeController, KnowledgeState>(
  () => KnowledgeController(),
);

class KnowledgeController extends Notifier<KnowledgeState> {
  Future<void> databaseFillUpTest() async {
    final data = await rootBundle.loadString('assets/quiz_data/german.json');
    final knowledge = <Factoid>[];
    (json.decode(data) as Map<String, dynamic>).forEach((_, factoidJson) {
      knowledge.add(Factoid.fromMap(factoidJson));
    });

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
    ref.read(storageServiceProvider).init().whenComplete(readDatabaseTest);
    return KnowledgeState([]);
  }
}
