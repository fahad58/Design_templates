import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
class NotiService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  //init
  Future<void> initNotification() async {
    if (_isInitialized) return;

    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    const initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true
    );
    const initSettings = InitializationSettings(iOS: initSettingsIOS, android: initSettingsAndroid);
    await notificationsPlugin.initialize(initSettings);
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(android: AndroidNotificationDetails('daily_channel_id', 'Daily Notifications', channelDescription: 'Daily Notification Channel', importance: Importance.max, priority: Priority.high),iOS: DarwinNotificationDetails());
  }

  Future<void> showNotification({int id = 0, String? title, String? body}) async {
    return notificationsPlugin.show(id, title, body, const NotificationDetails());
  }

  Future<void> scheduleNotification({int id = 1, required String title, required String body, required int hour, required int minute}) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    await notificationsPlugin.zonedSchedule(
      id, title ,body, scheduledDate, const NotificationDetails(),
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle
    );
    print('scheduled');
  }

  //Cancel as well
  Future<void> cancelAllNotifications() async {
    await notificationsPlugin.cancelAll();
  }


}