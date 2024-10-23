import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'hive_storage_service.dart';

final storageServiceProvider = Provider<StorageService>(
  (_) => HiveStorageService(),
);

// enum StorageKey { factoids }
typedef StorageKey = String;

/// Abstract class defining [StorageService] structure
abstract class StorageService {
  Future<void> init();

  /// Get value by key
  Object? getValue(StorageKey key);

  /// Store new value
  Future<void> setValue({required StorageKey key, required Object? data});

  /// Delete value by key
  Future<void> deleteValue(StorageKey key);

  /// Clear storage
  Future<void> clear();
}
