import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/core/constants/app_text_styles.dart';
import 'package:e_commerce_app/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingBody extends StatelessWidget {
   OnBoardingBody({super.key, required this.pageController});
   final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 590,
      child: PageView(
        controller: pageController,
        children: [
          Column(
            children: [
              SvgPicture.asset(Assets.imagesBoard1),
              SizedBox(height: 20),
              Text("Choose Products", style: AppTextStyles.poppins500style24.copyWith(fontSize: 30,fontWeight: FontWeight.w700)),
              SizedBox(height: 20),
              Text("\t\tFashion & Clothes & All u need", style: AppTextStyles.poppins500style24.copyWith(fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.fontGrey)),
              Text("\t\tIn one place", style: AppTextStyles.poppins500style24.copyWith(fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.fontGrey)),
            ],
          ),

          Column(
            children: [
              SizedBox(height: 30),
              SvgPicture.asset(Assets.imagesBoard2),
              SizedBox(height: 55),
              Text("Make Payment", style: AppTextStyles.poppins500style24.copyWith(fontSize: 30,fontWeight: FontWeight.w700)),
              SizedBox(height: 20),
              Text("\t\tAll methods of payment available", style: AppTextStyles.poppins500style24.copyWith(fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.fontGrey)),
              Text("\t\tcash ,vodafone cash ,credit cards", style: AppTextStyles.poppins500style24.copyWith(fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.fontGrey)),
            ],
          ),
          Column(
            children: [
              SvgPicture.asset(Assets.imagesBoard3),

              Text("Get Your Order", style: AppTextStyles.poppins500style24.copyWith(fontSize: 30,fontWeight: FontWeight.w700)),
              SizedBox(height: 20),
              Text("\t\tYour order is ready for pickup", style: AppTextStyles.poppins500style24.copyWith(fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.fontGrey)),
              Text("\t\tDon't miss the opportunity", style: AppTextStyles.poppins500style24.copyWith(fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.fontGrey)),
            ],
          ),

        ],
      ),
    );
  }
}
