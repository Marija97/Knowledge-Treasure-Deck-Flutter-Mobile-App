import 'package:hive_flutter/hive_flutter.dart';

import 'storage_service.dart';

/// Implementation of [StorageService] with [Hive]
class HiveStorageService extends StorageService {
  late Box<dynamic> hiveBox;

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    hiveBox = await Hive.openBox('box');
  }

  @override
  Object? getValue(StorageKey key) => hiveBox.get(key.name) as Object?;

  @override
  Future<void> setValue({required StorageKey key, required Object? data}) async {
    hiveBox.put(key.name, data);
  }

  @override
  Future<void> deleteValue(StorageKey key) async => hiveBox.delete(key.name);

  @override
  Future<void> clear() async => hiveBox.clear();
}
