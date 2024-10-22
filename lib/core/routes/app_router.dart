
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/login_screen.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/reset_password.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:e_commerce_app/features/home/domain/entities/home_entity.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home.dart';
import 'package:e_commerce_app/features/home/presentation/pages/item_details_screen.dart';
import 'package:e_commerce_app/features/onBoarding/onboarding_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/cubit/auth_state.dart';




// make string variables to carry name of paths like "/home" so when you change it change in one place
const String homePath = "/home";
const String firstPage = "/";
const String loginPath = "/login";
const String signUpPath = "/signup";
const String resetPasswordPath = "/resetPassword";
const String itemDetailsPath = "/itemDetails";


final GoRouter router = GoRouter(
  routes: [

    GoRoute(
      path: firstPage,
      builder: (context, state) {
        return Home();

       // return FirebaseAuth.instance.currentUser ==null? OnBoardingScreen() : BlocConsumer<HomeCubit,HomeState>(
       //    listener: (context,state){},
       //    builder: (context,state) => Home(),
       //  );

      },
    ),
    GoRoute(
      path: loginPath,
      builder: (context, state) =>
          BlocConsumer<AuthCubit,AuthState>(
            listener: (context,state){},
            builder: (context,state) => LoginScreen(),
          ),
    ),
    GoRoute(
      path: signUpPath,
      builder: (context, state) =>
          BlocConsumer<AuthCubit,AuthState>(
            listener: (context,state){},
            builder: (context,state) => SignUpScreen(),
          ),
    ),
    // GoRoute(
    //   path: homePath,
    //   builder: (context, state) =>
    //       BlocProvider(
    //         create: (context) => HomeCubit(),
    //         child: HomeScreen(),
    //       ),
    // ),
    GoRoute(
      path: resetPasswordPath,
      builder: (context, state) =>
          BlocConsumer<AuthCubit,AuthState>(
            listener: (context,state){},
            builder: (context,state) => ResetPassword(),
          ),
    ),
    GoRoute(path: itemDetailsPath,
        builder: (context,state) {
          final product = state.extra as ProductEntity;
              return     ItemDetailsScreen(product: product);
        },
    ),

  ],);