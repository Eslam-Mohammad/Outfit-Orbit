
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/login_screen.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/reset_password.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:e_commerce_app/features/onBoarding/onboarding_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/cubit/auth_state.dart';
import '../services/service_locator_get_it.dart';



// make string variables to carry name of paths like "/home" so when you change it change in one place
const String homePath = "/home";
const String onBoardingPath = "/";
const String loginPath = "/login";
const String signUpPath = "/signup";
const String resetPasswordPath = "/resetPassword";


final GoRouter router = GoRouter(
  routes: [

    GoRoute(
      path: onBoardingPath,
      builder: (context, state) =>  OnBoardingScreen(),
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

  ],);