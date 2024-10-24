
import 'package:e_commerce_app/features/home/presentation/manager/home_cubit.dart';
import 'package:e_commerce_app/features/home/presentation/manager/home_state.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/category_bar_builder.dart';

import 'package:e_commerce_app/features/home/presentation/widgets/products_grid.dart';
import 'package:e_commerce_app/features/home/presentation/widgets/search_bar_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import '../widgets/banner_builder.dart';


class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController searchController = TextEditingController();
  final pageController1 = PageController();
  ScrollController scrollController = ScrollController();

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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // search bar
            SizedBox(
              height: size.height * 0.03,
            ),
            SearchBarBuilder(searchController: searchController),

            // categories
            SizedBox(
              height: size.height * 0.02,
            ),
            CategoryBarBuilder(),

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
                BannerBuilder();
              },
            ),
            const SizedBox(height: 15,),
            // products
            ProductsGrid(),




          ],
        ),
      ),
    );
  }
}
