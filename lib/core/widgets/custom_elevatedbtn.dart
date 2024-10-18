
import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomElevatedbtn extends StatelessWidget {
  const CustomElevatedbtn({super.key, required this.text, required this.onPressed});
  final String text;
  final void Function () onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: ElevatedButton(
        onPressed:onPressed ,
        style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: AppColors.fontSecondaryColor,

      ),
        child:Text(text,
          style: AppTextStyles.poppins500style24.copyWith(fontSize:18.0,color: Colors.white ),),
      ),
    );
  }
}
