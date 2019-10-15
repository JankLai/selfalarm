import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtil {
     Future _insertNotification() async {
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
      // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
      var initializationSettingsAndroid =
          new AndroidInitializationSettings('app_icon');
      var initializationSettingsIOS = new IOSInitializationSettings(
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);
      var initializationSettings = new InitializationSettings(
          initializationSettingsAndroid, initializationSettingsIOS);
      flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
      var scheduledNotificationDateTime =
        new DateTime.now().add(new Duration(seconds: 5));
      var androidPlatformChannelSpecifics =
          new AndroidNotificationDetails('your other channel id',
              'your other channel name', 'your other channel description');
      var iOSPlatformChannelSpecifics =
          new IOSNotificationDetails();
      NotificationDetails platformChannelSpecifics = new NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.schedule(
          0,
          'scheduled title',
          'scheduled body',
          scheduledNotificationDateTime,
          platformChannelSpecifics);
    }

    Future onSelectNotification(String payload) async {
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
      }
      // await Navigator.push(
      //   context,
      //   new MaterialPageRoute(builder: (context) => new SecondScreen(payload)),
      // );
    }
    Future onDidReceiveLocalNotification(String payload) async {
      if (payload != null) {
        debugPrint('notification payload: ' + payload);
      }
     
    }
}