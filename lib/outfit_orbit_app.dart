

import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:e_commerce_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class OutfitOrbitApp extends StatelessWidget {
  OutfitOrbitApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: themeDataLight,
      routerConfig: router,

    );
  }
}