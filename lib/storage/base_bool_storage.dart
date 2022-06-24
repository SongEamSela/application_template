import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseBoolStorage {
  void saveBool({required bool value}) async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool(key(), value);
  }

  Future<bool?> getString() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool(key());
  }

  Future<void> removeBool() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove(key());
  }

  String key();
}
