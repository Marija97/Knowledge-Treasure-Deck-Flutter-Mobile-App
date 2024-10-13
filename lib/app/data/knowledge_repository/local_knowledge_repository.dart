import 'package:ash/app/data/knowledge_repository/knowledge_repository.dart';
import 'package:ash/app/data/models/factoid.dart';
import 'package:ash/app/services/storage/storage_service.dart';

class LocalKnowledgeRepository implements KnowledgeRepository {
  LocalKnowledgeRepository({required this.storage});

  final StorageService storage;

  @override
  void setupInitialKnowledge(List<Factoid> knowledge) {
    final encodedKnowledge = <String>[];
    for (final factoid in knowledge) {
      encodedKnowledge.add(factoid.toJson());
    }
    storage.setValue(key: StorageKey.factoids, data: encodedKnowledge);
  }

  @override
  List<Factoid> getKnowledge() {
    final encodedData = storage.getValue(StorageKey.factoids) as List<String>?;
    if (encodedData == null) return [];

    final knowledge = <Factoid>[];
    for (final data in encodedData) {
      final factoid = Factoid.fromJson(data);
      knowledge.add(factoid);
    }
    return knowledge;
  }

  @override
  void clear() {
    storage.deleteValue(StorageKey.factoids);
  }
}
