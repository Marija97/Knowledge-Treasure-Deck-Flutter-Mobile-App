import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/knowledge_repository/knowledge_repository.dart';
import 'knowledge_state.dart';

final knowledgeControllerProvider =
    NotifierProvider<KnowledgeController, KnowledgeState>(
  () => KnowledgeController(),
);

class KnowledgeController extends Notifier<KnowledgeState> {
  List<String> allCategories() {
    return ref.read(knowledgeRepositoryProvider).getCategories();
  }

  void selectCategory(String? category) {
    state = state.copyWith(selectedCategory: category);
  }

  @override
  KnowledgeState build() {
    return KnowledgeState(selectedCategory: null);
  }
}
