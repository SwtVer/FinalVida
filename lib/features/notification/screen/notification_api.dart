//import 'package:flutter/animation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:vida/features/notification/screen/utils.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    final bigPicture = await DownloadUtil.downloadAndSaveFile(
      //'https://unsplash.com/photos/yo01Z-9HQAw',
      "https://images.unsplash.com/photo-1624948465027-6f9b51067557?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
      'bigPicture',
    );
    /* final largeIconPath = await Utils.downloadFile(
    'https://images.app.goo.gl/UbhU3kXHzjSYpzjP8',
    'largeIcon',
    );*/
    /*final bigPicturePath = await Utils.downloadFile(
    'https://unsplash.com/photos/S1v7hVUiCg0',
    'bigPicture',
    );
    final styleInformation = BigPictureStyleInformation(
    FilePathAndroidBitmap(bigPicturePath),
    //largeIcon: FilePathAndroidBitmap(largeIconPath)
    );*/
    // ignore: prefer_const_constructors
    return NotificationDetails(
      // ignore: prefer_const_constructors
      android: AndroidNotificationDetails(
        'channel id', 'channel name',
        //'channel description',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        ticker: 'ticker',
        largeIcon: const DrawableResourceAndroidBitmap('logo'),
        styleInformation: BigPictureStyleInformation(
          FilePathAndroidBitmap(bigPicture),
          hideExpandedLargeIcon: false,
        ), //styleInformation,
        //color: Color(0xff2196f3)
      ),
    );
  }

  static Future init({bool initScheduled = false}) async {
    //tz.initializeTimeZones();
    if (initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }

    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final ioS = IOSInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: ioS);
    //When app is closed
    final details = await _notifications.getNotificationAppLaunchDetails();
    //if (details != null && details.didNotificationLaunchApp) {
      //onNotifications.add(details.payload);
   // }
    await _notifications.initialize(settings,
        onSelectNotification: (payload) async {
      onNotifications.add(payload);
    });

    // final NotificationAppLaunchDetails? notificationAppLaunchDetails =
    //await FlutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );
  static Future showScheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async =>
      _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

  static void cancel(int id) => _notifications.cancel(id);
}
