import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedLocalStorageService extends ChangeNotifier {
  Future delete(String key) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  Future getMeds(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key);
  }

  Future getMed(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  Future set(String key, dynamic value) async {
    var prefs = await SharedPreferences.getInstance();
    if (value is String) {
      prefs.setString(key, value);
    } else if (value is List<String>) {
      prefs.setStringList(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    }
  }

  Future<DateTime?> getLastTakenDate(String key) async {
    var prefs = await SharedPreferences.getInstance();
    String? dateString = prefs.getString('$key-last-taken-date');
    return dateString != null ? DateTime.parse(dateString) : null;
  }

  Future setLastTakenDate(String key, DateTime date) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('$key-last-taken-date', date.toIso8601String());
  }
}
