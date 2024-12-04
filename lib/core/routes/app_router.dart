import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/login_screen.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/reset_password.dart';
import 'package:e_commerce_app/features/auth/presentation/screens/signup_screen.dart';
import 'package:e_commerce_app/features/chat/presentation/manager/chat_cubit.dart';
import 'package:e_commerce_app/features/chat/presentation/pages/admin_chat_screen.dart';
import 'package:e_commerce_app/features/home/domain/entities/home_entity.dart';
import 'package:e_commerce_app/features/home/presentation/pages/home.dart';
import 'package:e_commerce_app/features/home/presentation/pages/item_details_screen.dart';
import 'package:e_commerce_app/features/onBoarding/onboarding_screen.dart';
import 'package:e_commerce_app/features/profile/presentation/pages/help_center_screen.dart';
import 'package:e_commerce_app/features/profile/presentation/pages/my_account_screen.dart';
import 'package:e_commerce_app/features/profile/presentation/pages/notification_screen.dart';
import 'package:e_commerce_app/features/profile/presentation/pages/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/cubit/auth_state.dart';
import '../../features/chat/presentation/pages/chat_screen.dart';
import '../../features/home/presentation/manager/home_cubit.dart';
import '../../features/home/presentation/manager/home_state.dart';
import '../services/service_locator_get_it.dart';


// make string variables to carry name of paths like "/home" so when you change it change in one place
const String homePath = "/home";
const String firstPage = "/";
const String loginPath = "/login";
const String signUpPath = "/signup";
const String resetPasswordPath = "/resetPassword";
const String itemDetailsPath = "/itemDetails";
const String myAccountPath = "/myAccount";
const String helpCenterPath = "/helpCenter";
const String settingsPath = "/settings";
const String notificationPath = "/notification";
const String chatPath = "/chat";
const String adminChatPath = "/adminChat";


final GoRouter router = GoRouter(
  routes: [

    GoRoute(
      path: firstPage,
      builder: (context, state) {
        return FirebaseAuth.instance.currentUser == null
            ? OnBoardingScreen()
            : BlocConsumer<HomeCubit, HomeStates>(

          listener: (context, state) {},
          builder: (context, state) => const Home(),
        );
      },
    ),
    GoRoute(
      path: loginPath,
      builder: (context, state) =>
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {},
            builder: (context, state) => LoginScreen(),
          ),
    ),
    GoRoute(
      path: signUpPath,
      builder: (context, state) =>
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {},
            builder: (context, state) => const SignUpScreen(),
          ),
    ),
    GoRoute(
      path: homePath,
      builder: (context, state) => const Home(),

    ),
    GoRoute(
      path: resetPasswordPath,
      builder: (context, state) =>
          BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {},
            builder: (context, state) => ResetPassword(),
          ),
    ),
    GoRoute(path: itemDetailsPath,
      builder: (context, state) {
        final product = state.extra as ProductEntity;
        return ItemDetailsScreen(product: product);
      },
    ),
    GoRoute(
      path: myAccountPath,
      builder: (context, state) => const MyAccountScreen(),
    ),
    GoRoute(
      path: helpCenterPath,
      builder: (context, state) => const HelpCenterScreen(),
    ),
    GoRoute(
      path: settingsPath,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: notificationPath,
      builder: (context, state) => const NotificationScreen(),
    ),
    GoRoute(
      path: chatPath,
      builder: (context, state) {
        final params = state.extra as Map<String, dynamic>;
        return ChatScreen(
          messagesStream: params['messagesStream'] as Stream<
              QuerySnapshot<Object?>>,
          userIdToChatWith: params['userIdToChatWith'] as String,
        );
      },
    ),
    GoRoute(
      path: adminChatPath,
      builder: (context, state) => const AdminChatScreen(),
    ),


  ],
);