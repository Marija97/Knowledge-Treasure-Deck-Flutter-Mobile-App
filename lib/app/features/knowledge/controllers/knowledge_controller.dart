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

  int getTotalCount(String category){
    return ref.read(knowledgeRepositoryProvider).sizeOfSection(category);
  }

  int getObtainedCount(String category){
    return ref.read(knowledgeRepositoryProvider).obtainedCount(category);
  }

  @override
  KnowledgeState build() {
    return KnowledgeState(selectedCategory: null);
  }
}
