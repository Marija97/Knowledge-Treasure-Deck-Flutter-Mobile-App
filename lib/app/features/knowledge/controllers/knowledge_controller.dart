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

  Future<void> refreshFromRemoteDatabase() async {
    final result = await googleSheetManager.testReadData();
    if(result == null) return null;

    print("🌺 Got data: \n");
    final data = result["data"];
    final readLength = data?.length;

    var category = '';
    var ccc = '{';

    for (int i = 1; i < readLength; i++) {
      final rowData = data![i] as List<dynamic>;
      print('${i+1}: $rowData');

      if(rowData.first == '') continue;
      if(rowData[Columns.answer - 1] == '') { // is a category
        category = rowData[0] as String;
        continue;
      }
      final f = Factoid.fromGoogleSheetRow(row: i+1, data: rowData, category: category);
      final m = '"${f.category}: ${f.question}": ${f.toJson()}';

      final isLast = i == readLength - 1;
      ccc += '$m ${isLast ? '\n' : ', \n'}';
    }
    ccc += '}';

    await ref.read(knowledgeRepositoryProvider).clear();
    await ref.read(knowledgeRepositoryProvider).setupInitialKnowledge(ccc);
  }

  Future<void> testRemoteDatabaseWrite() async {
    // final result = await googleSheetManager.write(row: 8, data: [0, 0]);
    // print("🌺 Got result: $result");
  }

  Future<void> setFactoidStatus(int row, String status) async {
    await googleSheetManager.markStatus(row: row, status: status);
  }

  @override
  KnowledgeState build() {
    return KnowledgeState(selectedCategory: null);
  }
}
