import 'package:ash/app/services/storage/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/factoid.dart';
import 'local_knowledge_repository.dart';

final Provider<KnowledgeRepository> knowledgeRepositoryProvider =
    Provider<KnowledgeRepository>((ProviderRef<KnowledgeRepository> ref) {
  return LocalKnowledgeRepository(storage: ref.read(storageServiceProvider));
});

abstract class KnowledgeRepository {
  Future<void> setupInitialKnowledge(String jsonString);

  List<Factoid> getKnowledgeForCategory(String category);

  Set<String> getAllObtained(String category);

  Future<void> markAsObtained(Factoid factoid);

  List<String> getCategories();

  int sizeOfSection(String category);
  int obtainedCount(String category);

  Future<void> clear();
}
