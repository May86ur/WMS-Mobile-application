import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_10y.dart';

import '../main.dart';

class PermissionHandler {
  static requestPermissionsOnStartup() async {
    final PermissionStatus notificationStatus =
        await Permission.notification.request();
    if (notificationStatus != PermissionStatus.granted) {
    } else if (notificationStatus.isDenied) {
      requestPermissionsOnStartup();
    }
    final PermissionStatus locationStatus = await Permission.location.request();
    if (locationStatus != PermissionStatus.granted) {
    } else if (locationStatus.isDenied) {
      requestPermissionsOnStartup();
    }
  }

  static Future<void> showNotification(
      int id, String? title, String? desc) async {
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'test',
      'notification',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    // var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosDetails);

    await notificationsPlugin.show(
      id,
      title,
      desc,
      platformChannelSpecifics,
      payload: 'Default_Sound',
    );
  }

  static Future<void> scheduleNotifications() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? notifyme = preferences.getString('notify');
    String? username = preferences.getString('firstname');
    String? userType = preferences.getString('usertype');
    print("scheduling notifications");
    initializeTimeZones();
    print(tz.local.currentTimeZone);
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails("test", "notification",
            priority: Priority.max, importance: Importance.high);
    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    // Schedule notifications at 10 AM and 6 PM every day
    if ((notifyme ?? '').toLowerCase().contains('true')) {
      if ((userType ?? '').toLowerCase().contains('engineer')) {
        await notificationsPlugin.zonedSchedule(
          0,
          'Maintenece Report',
          "hey! ${(username ?? 'User')} Please check out the project maintenance report",
          tz.TZDateTime.from(_nextInstanceOfTime(10, 05, 0), tz.local),
          notificationDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.wallClockTime,
          matchDateTimeComponents: DateTimeComponents.time,
        );

        await notificationsPlugin.zonedSchedule(
          1,
          'Maintenece Report',
          "hey! ${(username ?? 'User')} Please check out the project maintenance report",
          tz.TZDateTime.from(_nextInstanceOfTime(18, 05, 0), tz.local),
          notificationDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.wallClockTime,
          matchDateTimeComponents: DateTimeComponents.time,
        );
        // await notificationsPlugin.zonedSchedule(
        //   2,
        //   'Maintenece Report',
        //   "hey! ${(username ?? 'User')} Please check out the project maintenance report",
        //   tz.TZDateTime.from(_nextInstanceOfTime(17, 16, 0), tz.local),
        //   notificationDetails,
        //   uiLocalNotificationDateInterpretation:
        //       UILocalNotificationDateInterpretation.wallClockTime,
        //   matchDateTimeComponents: DateTimeComponents.time,
        // );
      } else if ((userType ?? '').toLowerCase().contains('manager')) {
        await notificationsPlugin.zonedSchedule(
          0,
          'Maintenece Report',
          "hey! ${(username ?? 'User')} Please check out the project maintenance report",
          tz.TZDateTime.from(_nextInstanceOfTime(10, 10, 0), tz.local),
          notificationDetails,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.wallClockTime,
          matchDateTimeComponents: DateTimeComponents.time,
        );
      } else {
        print(" this User Don't have Report to Notify");
      }
    } else {
      print(" this User Don't have Report to Notify");
    }
  }

  static DateTime _nextInstanceOfTime(int hour, int minute, int seconds) {
    final now = DateTime.now();
    var scheduledDate =
        DateTime(now.year, now.month, now.day, hour, minute, seconds);
    if (scheduledDate.isBefore(now)) {
      print(scheduledDate.toString());
    }
    return scheduledDate;
  }

  static checkAllNotification() async {
    var list = await notificationsPlugin.pendingNotificationRequests();
    print(list);
    return list;
  }
}
