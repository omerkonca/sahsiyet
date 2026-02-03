import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Generic Save Methods
  static Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  static Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  static Future<void> saveInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  // Generic Load Methods
  static String? getString(String key) {
    return _prefs.getString(key);
  }

  static bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  static int? getInt(String key) {
    return _prefs.getInt(key);
  }

  // Object Saving Helper (JSON)
  static Future<void> saveItem(String key, Map<String, dynamic> item) async {
    final String jsonString = json.encode(item);
    await _prefs.setString(key, jsonString);
  }

  static Map<String, dynamic>? getItem(String key) {
    final String? jsonString = _prefs.getString(key);
    if (jsonString == null) return null;
    return json.decode(jsonString) as Map<String, dynamic>;
  }

  // List Saving Helper
  static Future<void> saveList(String key, List<Map<String, dynamic>> list) async {
    final String jsonString = json.encode(list);
    await _prefs.setString(key, jsonString);
  }

  static List<Map<String, dynamic>>? getList(String key) {
    final String? jsonString = _prefs.getString(key);
    if (jsonString == null) return null;
    
    final List<dynamic> decoded = json.decode(jsonString);
    return decoded.cast<Map<String, dynamic>>();
  }
}
