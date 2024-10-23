import 'package:ash/app/services/storage/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/factoid.dart';
import 'local_knowledge_repository.dart';

final Provider<KnowledgeRepository> knowledgeRepositoryProvider =
    Provider<KnowledgeRepository>((ProviderRef<KnowledgeRepository> ref) {
  return LocalKnowledgeRepository(storage: ref.read(storageServiceProvider));
});

abstract class KnowledgeRepository {
  void setupInitialKnowledge(String jsonString);

  List<Factoid> getKnowledgeForCategory(String category);

  List<String> getCategories();

  void clear();
}
