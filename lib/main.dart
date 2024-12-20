import 'package:e_commerce_app/core/databases/cache/cache_helper.dart';
import 'package:e_commerce_app/core/services/bloc_observer.dart';
import 'package:e_commerce_app/core/services/local_notifications_service.dart';
import 'package:e_commerce_app/core/services/push_notifications_service.dart';
import 'package:e_commerce_app/core/services/service_locator_get_it.dart' ;
import 'package:e_commerce_app/outfit_orbit_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';


import 'firebase_options.dart';

void main()async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);



  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

Future.wait([
  PushNotificationsService.init(),
  LocalNotificationService.init(),
  CacheHelper.init(),
]);

  Bloc.observer = const AppBlocObserver();
    setup();

  runApp(const OutfitOrbitApp());
}




