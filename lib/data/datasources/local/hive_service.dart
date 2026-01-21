import 'package:hive/hive.dart';
import '../../../core/constants/storage_constants.dart';

class HiveService {
  Box<T> getBox<T>(String boxName) {
    return Hive.box<T>(boxName);
  }

  Future<void> put<T>(String boxName, String key, T value) async {
    final box = getBox(boxName);
    await box.put(key, value);
  }

  T? get<T>(String boxName, String key) {
    final box = getBox(boxName);
    return box.get(key) as T?;
  }

  Future<void> delete(String boxName, String key) async {
    final box = getBox(boxName);
    await box.delete(key);
  }

  Future<void> clear(String boxName) async {
    final box = getBox(boxName);
    await box.clear();
  }

  List<T> getAll<T>(String boxName) {
    final box = getBox(boxName);
    return box.values.cast<T>().toList();
  }

  Future<void> clearAllData() async {
    await Hive.box(StorageConstants.authBox).clear();
    await Hive.box(StorageConstants.todoBox).clear();
    await Hive.box(StorageConstants.userBox).clear();
    // Don't clear settings box to preserve user preferences
  }
}