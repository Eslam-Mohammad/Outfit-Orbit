import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'local_notifications_service.dart';


class PushNotificationsService {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future init() async {
    await messaging.requestPermission();
    await messaging.getToken().then((value) {
      log ('###########################################  token: $value');
      sendTokenToServer(value!);
    });
    messaging.onTokenRefresh.listen((value){
      sendTokenToServer(value);
    });


    // handle background and terminated states when just notification is received
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);


    //handel foreground state when notification is received
    handleForegroundMessage();

    messaging.subscribeToTopic('all').then((val){
      log('sub');
    });

    // messaging.unsubscribeFromTopic('all');
    setupInteractedMessage();
  }






  static Future<void> handleBackgroundMessage(RemoteMessage message) async {
    await Firebase.initializeApp();
    // logic to handle background message
    print('Handling a background message when notification is received');
  }




  static void handleForegroundMessage() {
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        // show local notification
        log('Handling a foreground message when notification is received');
        LocalNotificationService.showBasicNotification(
          message,
        );
      },
    );
  }

  static void sendTokenToServer(String token) {
    // option 1 => API 
    // option 2 => Firebase 
  }

 static Future<void> setupInteractedMessage() async {

    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();


    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }


    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }



  static void _handleMessage(RemoteMessage message) {
    log ("handle tap on notification on background ");

  }




}

