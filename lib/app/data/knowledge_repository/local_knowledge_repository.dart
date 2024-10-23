import 'dart:convert';

import 'package:ash/app/data/knowledge_repository/knowledge_repository.dart';
import 'package:ash/app/data/models/factoid.dart';
import 'package:ash/app/services/storage/storage_service.dart';

class LocalKnowledgeRepository implements KnowledgeRepository {
  LocalKnowledgeRepository({required this.storage});

  final StorageService storage;

  @override
  void setupInitialKnowledge(String jsonString) {
    // section the knowledge database by categories to be saved and loaded
    // individually
    final knowledgeByCategory = Map<String, List<String>>();
    final categories = <String>[];

    (json.decode(jsonString) as Map<String, dynamic>).forEach((_, factoidJson) {
      // final factoid = Factoid.fromMap(factoidJson);
      final category = factoidJson["category"];

      if (knowledgeByCategory.containsKey(category)) {
        knowledgeByCategory[category]!.add(factoidJson);
      } else {
        categories.add(category);
        knowledgeByCategory[category] = [factoidJson];
      }
    });

    // fills up the database with entries category: List of factoids in jsonstr
    for (final category in knowledgeByCategory.keys) {
      storage.setValue(key: category, data: knowledgeByCategory[category]);
    }

    // save the list of categories
    storage.setValue(key: 'categories', data: categories);
  }

  @override
  List<Factoid> getKnowledgeForCategory(String category) {
    final encodedData = storage.getValue(category) as List<String>?;
    if (encodedData == null) throw Exception('Non existent category $category');

    return encodedData.map((data) => Factoid.fromJson(data)).toList();
  }

  @override
  void clear() {
    storage.clear();
  }

  @override
  List<String> getCategories() {
    return storage.getValue('categories') as List<String>;
  }
}
