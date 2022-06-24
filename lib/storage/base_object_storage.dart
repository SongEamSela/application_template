import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseObjectStorage {
  void saveObject({required Map<String, dynamic> value}) async {
    var pref = await SharedPreferences.getInstance();
    String json = jsonEncode(value);
    pref.setString(key(), json);
  }

  Future<Map<String, dynamic>?> getObject() async {
    var pref = await SharedPreferences.getInstance();
    String? json = pref.getString(key());
    if (json == null) return null;
    return jsonDecode(json);
  }

  Future<void> removeObject() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove(key());
  }

  String key();
}
