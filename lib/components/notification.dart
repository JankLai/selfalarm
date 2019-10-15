import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationWidget extends StatefulWidget {
  String _channelId = "1";
  String _channelName = "默认标题";
  String _description = "默认介绍";

  set channelId(String value) {
    _channelId = value;
  }
  String get channelId => _channelId;

  set channelName(String value) {
    _channelName = value;
  }
  String get channelName => _channelName;

  set description(String value) {
    _description = value;
  }
  String get description => _description;
  @override
  State<StatefulWidget> createState() => _NotificationState();
}

class _NotificationState extends State<NotificationWidget> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  @override
  initState() {
    super.initState();

    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: _onSelectNotification);
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new RaisedButton(
          onPressed: _insertNotification,
          child: new Text('Show Notification With Sound'),
        ),
      ],
    );
  }

  Future _onSelectNotification(String payload) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("payload"),
        content: Text("Payload: $payload"),
      )
    );
  }

  Future _insertNotification () async {
    if(widget._channelId != "1"){
      var scheduledNotificationDateTime =
        new DateTime.now().add(new Duration(seconds: 5));
      var androidPlatformChannelSpecifics =
          new AndroidNotificationDetails(widget._channelId,
              widget._channelName, widget.description,
              sound: 'slow_spring_board',
              importance: Importance.Max,
              ongoing: true,
              priority: Priority.High);
      var iOSPlatformChannelSpecifics =
          new IOSNotificationDetails();
      NotificationDetails platformChannelSpecifics = new NotificationDetails(
          androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
      await flutterLocalNotificationsPlugin.schedule(
          0,
          'scheduled title',
          'scheduled body',
          scheduledNotificationDateTime, //调度的时间
          platformChannelSpecifics,
          payload: '这是payload');
    }
    else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("payload"),
          content: Text("请在输入框输入内容！"),
        )
      );
    }
  }

}
