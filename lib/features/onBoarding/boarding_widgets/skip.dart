import 'package:e_commerce_app/core/constants/app_text_styles.dart';
import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SkipButtonWidget extends StatelessWidget {
  const SkipButtonWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(
            top: size.height * 0.06,
            right:  size.width * 0.05 ,

          ),
          child: TextButton(
            child: Text(
              'Skip',
              style: AppTextStyles.poppins500style24
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 18.0),
            ),
            onPressed: () {
              GoRouter.of(context).pushReplacement(loginPath);
            },
          ),
        ),
      ],
    );
  }
}