import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static Future<void> saveRemindLater(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, true);
  }

  static Future<bool> isRemindLaterSaved(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }
}
