import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/services/service_locator_get_it.dart';

import '../manager/home_cubit.dart';


class BannerBuilder extends StatefulWidget {
   const BannerBuilder({super.key });


  @override
  State<BannerBuilder> createState() => _BannerBuilderState();
}

class _BannerBuilderState extends State<BannerBuilder> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        CarouselSlider(

          items:getIt<HomeCubit>().homeBanners.map((banner) {
            return CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: banner.imageUrl,
              placeholder: (context, url) => SizedBox(
                width: size.width,
                height: 200.0,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.white,
                  child: Container(
                    color: Colors.grey,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            );
          }).toList(),
          options: CarouselOptions(

            onPageChanged: (index, reason) {
              setState(() {
                currentIndex = index;
              });
            },
            enlargeFactor: 20,
            enlargeCenterPage: true,
            height: 200,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayCurve: Curves.fastOutSlowIn,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
          ),
        ),
        SizedBox(
          height: size.height*0.02,
        ),

        AnimatedSmoothIndicator(activeIndex: currentIndex, count: 5, effect: const WormEffect(
          dotWidth: 10,
          spacing: 15,
          dotHeight: 10,
          activeDotColor: AppColors.fontSecondaryColor,
          dotColor: AppColors.fontSecondaryColor,
        ),),
      ],
    );

  }
}
