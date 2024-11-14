import 'package:e_commerce_app/core/services/service_locator_get_it.dart';
import 'package:e_commerce_app/features/home/presentation/manager/home_cubit.dart';
import 'package:e_commerce_app/features/home/presentation/manager/home_state.dart';

import 'package:e_commerce_app/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/routes/app_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});


  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(


            title: SvgPicture.asset(Assets.imagesLogo5),
            actions: [
              IconButton(
                iconSize: 28,
                icon: const Icon(Icons.notifications),
                onPressed: () {
                   GoRouter.of(context).push(notificationPath);
                },
              ),
              IconButton(
                iconSize: 28,
                icon: const Icon(Icons.search),
                onPressed: () {
                  getIt<HomeCubit>().changeIndex(3);
                },
              ),
            ],
          ),
          body: getIt<HomeCubit>().appScreens[getIt<HomeCubit>().currentIndex],
          bottomNavigationBar: ConvexAppBar(
            initialActiveIndex: getIt<HomeCubit>().currentIndex,
            height: size.height * 0.06,
            color: Colors.black,
            activeColor: Colors.red,
            backgroundColor: Colors.white,
            style: TabStyle.textIn,
            items: const [
              TabItem(icon: Icons.home_outlined, title: 'Home'),
              TabItem(icon: Icons.favorite_border, title: 'Whishlist'),
              TabItem(icon: Icons.shopping_cart_outlined, title: 'Cart'),
              TabItem(icon: Icons.search, title: 'Search'),
              TabItem(icon: Icons.person_2_outlined, title: 'Profile'),
            ],
            onTap: (int i) {
              getIt<HomeCubit>().changeIndex(i);

            },
          ),
        );
      },
    );
  }
}
