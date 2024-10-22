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
  late Map<String, List<Factoid>> _factoidsByCategory;

  final selectedCategory = 'irregular_verbs_common'; // Todo selected by user!

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
    _factoidsByCategory = Map<String, List<Factoid>>();

    // collect factoids into their category group
    for(final factoid in units){
      if (_factoidsByCategory.containsKey(factoid.category)) {
        _factoidsByCategory[factoid.category]!.add(factoid);
      } else {
        _factoidsByCategory[factoid.category] = [factoid];
      }
    }

    state = KnowledgeState(units);
  }

  List<Factoid> getQuizData(){
    return _factoidsByCategory[selectedCategory]!..shuffle();
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
