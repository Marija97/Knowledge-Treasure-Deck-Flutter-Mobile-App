import 'dart:convert';
import 'dart:math';

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
      final factoid = Factoid.fromMap(factoidJson);
      knowledge.add(factoid);


    });

    ref.read(knowledgeRepositoryProvider).setupInitialKnowledge(knowledge);
  }

  void readDatabaseTest() {
    final units = ref.read(knowledgeRepositoryProvider).getKnowledge();

    // prepare quests
    final _factoidsByCategory = Map<String, List<Factoid>>();

    // collect factoids into their category group
    for(final factoid in units){
      if (_factoidsByCategory.containsKey(factoid.category)) {
        _factoidsByCategory[factoid.category]!.add(factoid);
      } else {
        _factoidsByCategory[factoid.category] = [factoid];
      }
    }

    state = state.copyWith(factoidsByCategory: _factoidsByCategory);
  }

  List<Factoid> getQuizData(){
    // all the factoids from the selected category
    return state.getSection()..shuffle(Random(0));
  }

  void clearDatabaseTest() {
    ref.read(knowledgeRepositoryProvider).clear();
  }

  @override
  KnowledgeState build() {
    ref.read(storageServiceProvider).init().whenComplete(readDatabaseTest);
    // Todo selected by user!
    // Todo read from a variable
    return KnowledgeState(factoidsByCategory: null, selectedCategory: null);
  }
}
