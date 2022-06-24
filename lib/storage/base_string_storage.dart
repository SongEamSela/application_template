import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseStringStorage {
  Future<void> saveString({required String value}) async {
    var pref = await SharedPreferences.getInstance();
    pref.setString(key(), value);
  }

  Future<String?> getString() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getString(key());
  }

  Future<void> removeString() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove(key());
  }

  String key();
}
