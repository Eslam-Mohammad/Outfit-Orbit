import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:e_commerce_app/features/onBoarding/boarding_widgets/boarding_body.dart';
import 'package:e_commerce_app/features/onBoarding/boarding_widgets/skip.dart';
import 'package:e_commerce_app/features/onBoarding/boarding_widgets/smooth_indicator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnBoardingScreen extends StatelessWidget {
   OnBoardingScreen({super.key});
  final pageController = PageController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SkipButtonWidget(size: size),
            SizedBox(height: size.height * 0.1),

            OnBoardingBody(pageController: pageController),
            SizedBox(height: size.height * 0.04),


            Row(children: [
              SizedBox(width: size.width * 0.4),
              CustomSmoothPageIndicator(pageController: pageController),
              SizedBox(width: size.width * 0.2),
              TextButton(
                  onPressed: (){
                    if (pageController.page == 2) {
                      GoRouter.of(context).pushReplacement(loginPath);
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      );
                    }
                  },
                  child: Text("Next", style: TextStyle(color: AppColors.fontSecondaryColor, fontSize: 20),)
              )

            ],),


          ],
        ),
      ),
    );
  }
}