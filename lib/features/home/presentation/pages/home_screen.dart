
import 'package:e_commerce_app/features/home/presentation/manager/home_cubit.dart';
import 'package:e_commerce_app/features/home/presentation/manager/home_state.dart';


import 'package:e_commerce_app/features/home/presentation/widgets/products_grid.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/banner_builder.dart';


class HomeScreen extends StatelessWidget {
    HomeScreen({super.key});

  final TextEditingController searchController = TextEditingController();
  final pageController1 = PageController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size;
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        context.read<HomeCubit>().getProducts();
      }
    });




    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            // search bar
            SizedBox(
              height: size.height * 0.03,
            ),
            

            // categories
            SizedBox(
              height: size.height * 0.02,
            ),
            //CategoryBarBuilder(),

            //banners
            BlocBuilder<HomeCubit, HomeStates>(
              builder: (context, state) {
                return state is HomeBannersLoading?
                SizedBox(
                  width: size.width,
                  height: 160.0,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: Container(
                      color: Colors.grey,
                    ),
                  ),
                ) :
                const BannerBuilder();
              },
            ),
            const SizedBox(height: 15,),
            // products
            const ProductsGrid(),




          ],
        ),
      ),
    );
  }
}
