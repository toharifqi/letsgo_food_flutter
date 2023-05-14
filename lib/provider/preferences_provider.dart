import 'package:flutter/foundation.dart';
import 'package:letsgo_food/data/preferences/preference_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({required this.preferencesHelper}) {
    _getNotificationStatus();
  }

  bool _isNotificationActive = false;
  bool get isNotificationActive => _isNotificationActive;

  void _getNotificationStatus() async {
    _isNotificationActive = await preferencesHelper.isNotificationActive;
    notifyListeners();
  }

  void setNotification(bool value) {
    preferencesHelper.setNotification(value);
    _getNotificationStatus();
  }
}
