import 'dart:convert';

import 'package:ash/app/data/knowledge_repository/knowledge_repository.dart';
import 'package:ash/app/data/models/factoid.dart';
import 'package:ash/app/services/storage/storage_service.dart';

class LocalKnowledgeRepository implements KnowledgeRepository {
  LocalKnowledgeRepository({required this.storage});

  final StorageService storage;

  @override
  Future<void> setupInitialKnowledge(String jsonString) async {
    // section the knowledge database by categories to be saved and loaded
    // individually
    final knowledgeByCategory = Map<String, List<String>>();
    final categories = <String>[];

    (json.decode(jsonString) as Map<String, dynamic>).forEach((_, factoidJson) {
      // final factoid = Factoid.fromMap(factoidJson);
      final category = factoidJson["category"];
      final value = json.encode(factoidJson);

      if (knowledgeByCategory.containsKey(category)) {
        knowledgeByCategory[category]!.add(value);
      } else {
        categories.add(category);
        knowledgeByCategory[category] = [value];
      }
    });

    // fills up the database with entries category: List of factoids in jsonstr
    await Future.forEach<String>(knowledgeByCategory.keys, (category) {
      storage.setValue(key: category, data: knowledgeByCategory[category]);
    });

    // save the list of categories
    await storage.setValue(key: 'categories', data: categories);
  }

  @override
  List<Factoid> getKnowledgeForCategory(String category) {
    final encodedData = storage.getValue(category) as List<String>?;
    if (encodedData == null) throw Exception('Non existent category $category');

    return encodedData.map((data) => Factoid.fromJson(data)).toList();
  }

  @override
  Future<void> clear() async {
    await storage.clear();
  }

  @override
  List<String> getCategories() {
    return storage.getValue('categories') as List<String>;
  }

  @override
  Set<String> getAllObtained(String category) {
    return storage.getValue('obtained_$category') as Set<String>;
  }

  @override
  Future<void> markAsObtained(Factoid factoid) async {
    final values = getAllObtained(factoid.category)..add(factoid.key);
    await storage.setValue(key: 'obtained_${factoid.category}', data: values);
  }
}
