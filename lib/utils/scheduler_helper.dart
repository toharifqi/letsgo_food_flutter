import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

import 'background_service.dart';
import 'date_time_helper.dart';

class SchedulerHelper {
  static SchedulerHelper? _instance;

  SchedulerHelper._internal() {
    _instance = this;
  }

  factory SchedulerHelper() => _instance ?? SchedulerHelper._internal();

  Future<bool> scheduleNotification(bool isScheduled) async {
    if (isScheduled) {
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
