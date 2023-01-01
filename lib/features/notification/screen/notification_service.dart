import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationsServices {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final AndroidInitializationSettings _androidInitializationSettings =
      AndroidInitializationSettings('logo');

  void initialiseNotifications() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: _androidInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  /*void*/  void sendNotification(String title, String body) async {
   AndroidNotificationDetails androidNotificationDetails =

    AndroidNotificationDetails(
      'channel id', 
    'channel name',
    importance: Importance.max,
    priority: Priority.high,
    //'channel description',
    );
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails
    );

    await _flutterLocalNotificationsPlugin.show(
        
      0, 
      title, 
      body, 
      notificationDetails
      );
  }
}
