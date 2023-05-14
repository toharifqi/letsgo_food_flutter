import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const notification = "NOTIFICATION_PREF_KEY";

  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({required this.sharedPreferences});

  Future<bool> get isNotificationActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(notification) ?? false;
  }

  void setNotification(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(notification, value);
  }
}
