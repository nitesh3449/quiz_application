import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class PreferenceHelper {
  static const String bestScore = "bestScore";
  static const String percentage = "percentage";
  static const String questionList = "questionList";

  static Future<SharedPreferences> getInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static Future<bool> setPreferencesData(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<String?> getPreferencesData(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<void> clearPreferenceData(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static Future<bool> setDoublePreferencesData(key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setDouble(key, value);
  }

  static Future<double?> getDoublePreferencesData(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(key);
  }
}