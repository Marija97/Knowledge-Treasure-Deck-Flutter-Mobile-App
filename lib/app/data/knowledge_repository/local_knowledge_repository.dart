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

    await Future.forEach<String>(knowledgeByCategory.keys, (category) {
      // fills up the database with entries category: List of factoids
      final factoids = knowledgeByCategory[category]!;
      storage.setValue(key: category, data: factoids);

      // save the total size of the category for status data
      storage.setValue(key: totalCountKey(category), data: factoids.length);

      // save the number of for quick access
      final obtained = getAllObtained(category);
      storage.setValue(key: obtainedCountKey(category), data: obtained.length);
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

  static allObtainedKey(String category) => 'obtained_$category';

  @override
  Set<String> getAllObtained(String category) {
    final storageValue = storage.getValue(allObtainedKey(category));
    if (storageValue == null) return {};

    return Set<String>.from((storageValue as List)..cast<String>());
  }

  @override
  Future<void> markAsObtained(Factoid factoid) async {
    final category = factoid.category;
    final values = await getAllObtained(category)..add(factoid.key);
    final key = allObtainedKey(category);
    await storage.setValue(key: key, data: List.from(values));

    // update static obtained count
    final count = storage.getValue(obtainedCountKey(category)) as int;
    await storage.setValue(key: obtainedCountKey(category), data: count + 1);
  }

  /// status related methods
  static obtainedCountKey(String category) => 'status_obtained_$category';

  static totalCountKey(String category) => 'status_total_$category';

  @override
  int obtainedCount(String category) {
    return storage.getValue(obtainedCountKey(category)) as int;
  }

  @override
  int sizeOfSection(String category) {
    return storage.getValue(totalCountKey(category)) as int;
  }
}
