import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:know_flow/app/services/network/google_sheet_manager.dart';

import '../../../data/knowledge_repository/knowledge_repository.dart';
import '../../../data/models/factoid.dart';
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
    var category = '';

    for (int i = 1; i < 6; i++) {
    // for (int i = 1; i < (data?.length ?? 0); i++) {
      final rowData = data![i] as List<dynamic>;
      print('${i+1}: $rowData');

      if(i < 2) continue;
      if(rowData.first == '') continue;
      if(rowData[Columns.answer - 1] == '') { // is a category
        category = rowData[0] as String;
        continue;
      }
      final factoid = Factoid.fromGoogleSheetRow(row: i+1, data: rowData, category: category);
      print(factoid);
    }

    return result;
  }

  Future<void> testRemoteDatabaseWrite() async {
    // final result = await googleSheetManager.write(row: 8, data: [0, 0]);
    // print("🌺 Got result: $result");
  }

  Future<void> testFlagSet(String s) async {
    final result = await googleSheetManager.markStatus(row: 8, status: s);
    print("🌺 Got result: $result");
  }

  @override
  KnowledgeState build() {
    return KnowledgeState(selectedCategory: null);
  }
}
