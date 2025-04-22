import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:know_flow/app/services/network/google_sheet_manager.dart';

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

  void setDataRefreshingStatus(String status){
    state = state.copyWith(status: status);
  }

  final googleSheetManager = GoogleSheetManager();

  Future<Map<String, dynamic>?> testRemoteDatabaseRead() async {
    final result = await googleSheetManager.testReadData();
    if(result == null) return null;

    print("🌺 Got data: \n");
    final data = result["data"];

    for (int i = 0; i < (data?.length ?? 0); i++) {
      final rowData = data![i];
      print('$i: $rowData');
    }

    return result;
  }

  Future<void> testRemoteDatabaseWrite() async {
    final result = await googleSheetManager.testWrite(row: 7, data: ['0', '0']);
    print("🌺 Got result: $result");
  }

  @override
  KnowledgeState build() {
    return KnowledgeState(selectedCategory: null);
  }
}
