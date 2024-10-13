import 'package:ash/app/services/storage/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/factoid.dart';
import 'local_knowledge_repository.dart';

final Provider<KnowledgeRepository> knowledgeRepositoryProvider =
    Provider<KnowledgeRepository>((ProviderRef<KnowledgeRepository> ref) {
  return LocalKnowledgeRepository(storage: ref.read(storageServiceProvider));
});

abstract class KnowledgeRepository {
  void setupInitialKnowledge(List<Factoid> knowledge);

  List<Factoid> getKnowledge();

  void clear();
}
