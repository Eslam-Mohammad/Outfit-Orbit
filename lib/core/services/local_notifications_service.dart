import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static StreamController<NotificationResponse> streamController = StreamController();

  static onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);

  }

  static Future init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );

  }

  //basic Notification
  static void showBasicNotification(RemoteMessage message) async {
    BigPictureStyleInformation? bigPictureStyleInformation;
    if(message.notification?.android?.imageUrl!=null){
      final http.Response image = await http
          .get(Uri.parse(message.notification!.android!.imageUrl! ));

      bigPictureStyleInformation =
          BigPictureStyleInformation(
            ByteArrayAndroidBitmap.fromBase64String(
              base64Encode(image.bodyBytes),
            ),
            largeIcon: ByteArrayAndroidBitmap.fromBase64String(
              base64Encode(image.bodyBytes),
            ),
          );
    }



    AndroidNotificationDetails android = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
      playSound: true,


    );

    NotificationDetails details = NotificationDetails(
      android: android,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      details,
    );

  }
}