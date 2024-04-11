import 'dart:convert';

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
      print('String');
      prefs.setString(key, value);
    } else if (value is List<String>) {
      print('List');
      prefs.setStringList(key, value);
    } else if (value is Map) {
      // final DateTime _today = DateTime.now();

      // prefs.setString(
      //   key,
      //   jsonEncode({
      //     'Data': value.today,'Tomei': value.taken:
      //   }),
      // );
    } else if (value is bool) {
      print('bool');
      prefs.setBool(key, value);
    }
  }
}
