import 'package:hive/hive.dart';
import '../../data/models/user_model.dart';
import '../../data/models/todo_model.dart';
import '../../data/models/settings_model.dart';

class HiveService {
  static const String _boxName = 'app_box';

  static const String _usersKey = 'users';
  static const String _currentUserKey = 'current_user';
  static const String _todosKey = 'todos';
  static const String _settingsKey = 'settings';

  late Box _box;

  Future<void> init() async {
    _box = await Hive.openBox(_boxName);
  }

  Future<void> saveUsers(List<UserModel> users) async {
    await _box.put(_usersKey, users.map((u) => u.toJson()).toList());
  }

  List<UserModel> getUsers() {
    final raw = _box.get(_usersKey);
    if (raw is! List) return [];
    return raw
        .whereType<Map>()
        .map((m) => UserModel.fromJson(Map<String, dynamic>.from(m)))
        .toList();
  }

  Future<void> setCurrentUser(UserModel? user) async {
    if (user == null) {
      await _box.delete(_currentUserKey);
      return;
    }
    await _box.put(_currentUserKey, user.toJson());
  }

  UserModel? getCurrentUser() {
    final raw = _box.get(_currentUserKey);
    if (raw is! Map) return null;
    return UserModel.fromJson(Map<String, dynamic>.from(raw));
  }

  Future<void> clearAuth() async {
    await _box.delete(_currentUserKey);
  }

  Future<void> saveTodos(List<TodoModel> todos) async {
    await _box.put(_todosKey, todos.map((t) => t.toJson()).toList());
  }

  List<TodoModel> getTodos() {
    final raw = _box.get(_todosKey);
    if (raw is! List) return [];
    return raw
        .whereType<Map>()
        .map((m) => TodoModel.fromJson(Map<String, dynamic>.from(m)))
        .toList();
  }

  Future<void> saveSettings(SettingsModel settings) async {
    await _box.put(_settingsKey, settings.toJson());
  }

  SettingsModel getSettings() {
    final raw = _box.get(_settingsKey);
    if (raw is! Map) return SettingsModel.defaultSettings;
    return SettingsModel.fromJson(Map<String, dynamic>.from(raw));
  }

  Future<void> clearAllData() async {
    await _box.clear();
  }

  Future<void> close() async {
    await _box.close();
  }
}
