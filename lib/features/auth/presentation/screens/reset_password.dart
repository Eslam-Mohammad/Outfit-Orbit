import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/core/constants/app_text_styles.dart';
import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:e_commerce_app/core/widgets/custom_elevatedbtn.dart';

import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/email_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/service_locator_get_it.dart';

class ResetPassword extends StatelessWidget {
   ResetPassword({super.key});
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.fontSecondaryColor,
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(

              children: [
                const SizedBox(height: 40.0,),
                const Text("Forgot Password",
                style:AppTextStyles.poppins500style24 ,
                ),
                const SizedBox(height: 40.0,),
                Image.asset("assets/images/padlock.png",height: 200,width: 200,),
                const SizedBox(height: 25.0,),
                RichText(text: TextSpan(
                  text: "Enter your registered email below to receive ",
                      style: AppTextStyles.poppins500style24.copyWith(color: Colors.grey,fontSize: 16.0),
                  children: [
                    TextSpan(
                      text: "\n          password reset instructions",
                      style: AppTextStyles.poppins500style24.copyWith(color: Colors.grey,fontSize: 16.0),
                    )
                  ],
                )),
                const SizedBox(height: 40.0,),
                CustomEmailTextField(emailController: emailController, color: AppColors.fontGrey),
                const SizedBox(height: 150.0,),
                BlocConsumer<AuthCubit, AuthState>(
                   listener: (context, state) {
                      if (state is ResetPasswordSuccess) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Check your email"),backgroundColor: Colors.green,));
                        GoRouter.of(context).pushReplacement(loginPath);
                      } else if (state is ResetPasswordFailure) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message),backgroundColor: Colors.red,));
                      }
                 },
                    builder: (context, state) {
                      return state is ResetPasswordLoading?
                      const CircularProgressIndicator():
                      CustomElevatedbtn(text: "Send Reset Password Link", onPressed: (){

                        getIt<AuthCubit>().resetUserPassword( emailController.text);


                });
  },
),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
