import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static Future<void> saveRemindLater(String cardGroupId, String localCardId) async {
    final key = getRemindLaterKey(cardGroupId, localCardId);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, true);
  }

  static Future<bool> isRemindLaterSaved(String cardGroupId, String localCardId) async {
    final key = getRemindLaterKey(cardGroupId, localCardId);
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<void> removeAllRemindLater() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getKeys().forEach((key) {
      if (key.contains('remind-later')) {
        prefs.remove(key);
      }
    });
  }

  static Future<void> saveDismissCard(String cardGroupId, String localCardId) async {
    final key = getDismissCardKey(cardGroupId, localCardId);
    print("Key: $key");
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, true);
  }

  static Future<bool> isDismissCardSaved(String cardGroupId, String localCardId) async {
    final key = getDismissCardKey(cardGroupId, localCardId);
    print("Key: $key");
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  static Future<void> removeAllDismissCard() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getKeys().forEach((key) {
      if (key.contains('dismiss-card')) {
        prefs.remove(key);
      }
    });
  }



  static String getRemindLaterKey(String cardGroupId, String localCardId) {
    return '$cardGroupId-$localCardId-remind-later';
  }

  static String getDismissCardKey(String cardGroupId, String localCardId) {
    return '$cardGroupId-$localCardId-dismiss-card';
  }
}
