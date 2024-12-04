

import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:e_commerce_app/core/theme/app_theme.dart';
import 'package:e_commerce_app/features/home/presentation/manager/home_cubit.dart';
import 'package:e_commerce_app/features/wishlist/presentation/manager/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/services/service_locator_get_it.dart';
import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/cart/presentation/manager/cart_cubit.dart';
import 'features/chat/presentation/manager/chat_cubit.dart';
import 'features/search/presentation/manager/search_cubit.dart';

class OutfitOrbitApp extends StatelessWidget {
 const OutfitOrbitApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WishlistCubit>(create: (context) => getIt<WishlistCubit>()),
        BlocProvider<HomeCubit>(create: (context) => getIt<HomeCubit>()),
        BlocProvider<CartCubit>(create: (context) => getIt<CartCubit>()),
        BlocProvider<AuthCubit>(create: (context) => getIt<AuthCubit>()),
        BlocProvider<SearchCubit>(create: (context) => getIt<SearchCubit>()),
        BlocProvider<ChatCubit>(create: (context)=>getIt<ChatCubit>()),


      ],
      child: MaterialApp.router(

        debugShowCheckedModeBanner: false,
        theme: themeDataLight,
        routerConfig: router,

      ),
    );
  }
}