
import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSmoothPageIndicator extends StatelessWidget {
  const CustomSmoothPageIndicator({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(controller: pageController,
        count: 3,
        effect: const ExpandingDotsEffect(

          spacing: 12.0,
          dotWidth: 10,
          dotHeight: 10,
          activeDotColor: AppColors.fontSecondaryColor,
          dotColor: AppColors.fontSecondaryColor,
        )
    );
  }
}