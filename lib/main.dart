import 'package:e_commerce_app/core/databases/cache/cache_helper.dart';
import 'package:e_commerce_app/core/services/bloc_observer.dart';
import 'package:e_commerce_app/core/services/service_locator_get_it.dart' ;
import 'package:e_commerce_app/outfit_orbit_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
CacheHelper.init();


  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance
      .authStateChanges()
      .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });

  Bloc.observer = const AppBlocObserver();
    setup();

  runApp( const OutfitOrbitApp());
}




