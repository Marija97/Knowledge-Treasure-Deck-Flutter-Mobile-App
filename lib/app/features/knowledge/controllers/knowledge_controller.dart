import 'package:ash/app/services/storage/storage_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/knowledge_repository/knowledge_repository.dart';
import 'knowledge_state.dart';

final knowledgeControllerProvider =
    NotifierProvider<KnowledgeController, KnowledgeState>(
  () => KnowledgeController(),
);

class KnowledgeController extends Notifier<KnowledgeState> {
  Future<void> refreshDatabase() async {
    final data = await rootBundle.loadString('assets/quiz_data/german.json');
    ref.read(knowledgeRepositoryProvider).setupInitialKnowledge(data);
  }

  List<String> allCategories() {
    return ref.read(knowledgeRepositoryProvider).getCategories();
  }

  void selectCategory(String? category) {
    state = state.copyWith(selectedCategory: category);
  }

  void clearDatabaseTest() {
    ref.read(knowledgeRepositoryProvider).clear();
  }

  @override
  KnowledgeState build() {
    ref.read(storageServiceProvider).init();
    // Todo selected by user!
    // Todo read from a variable
    return KnowledgeState(selectedCategory: null);
  }
}
