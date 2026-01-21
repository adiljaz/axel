import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  final SharedPreferences _prefs;

  SharedPrefService(this._prefs);

  // String operations
  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  // Boolean operations
  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // Int operations
  Future<bool> setInt(String key, int value) async {
    return await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  // JSON operations (for complex objects)
  Future<bool> setJson(String key, Map<String, dynamic> value) async {
    final jsonString = json.encode(value);
    return await _prefs.setString(key, jsonString);
  }

  Map<String, dynamic>? getJson(String key) {
    final jsonString = _prefs.getString(key);
    if (jsonString == null) return null;
    try {
      return json.decode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  // List operations
  Future<bool> setStringList(String key, List<String> value) async {
    return await _prefs.setStringList(key, value);
  }

  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  // JSON List operations
  Future<bool> setJsonList(String key, List<Map<String, dynamic>> value) async {
    final jsonList = value.map((item) => json.encode(item)).toList();
    return await _prefs.setStringList(key, jsonList);
  }

  List<Map<String, dynamic>>? getJsonList(String key) {
    final jsonStringList = _prefs.getStringList(key);
    if (jsonStringList == null) return null;
    try {
      return jsonStringList
          .map((item) => json.decode(item) as Map<String, dynamic>)
          .toList();
    } catch (e) {
      return null;
    }
  }

  // Remove operations
  Future<bool> remove(String key) async {
    return await _prefs.remove(key);
  }

  // Clear all data
  Future<bool> clearAll() async {
    return await _prefs.clear();
  }

  // Clear specific keys
  Future<void> clearAllExceptSettings() async {
    final keys = _prefs.getKeys();
    for (var key in keys) {
      if (!key.startsWith('settings_')) {
        await _prefs.remove(key);
      }
    }
  }

  // Check if key exists
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }

  // Get all keys
  Set<String> getAllKeys() {
    return _prefs.getKeys();
  }
}