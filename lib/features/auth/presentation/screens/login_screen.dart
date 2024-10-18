
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/core/constants/app_text_styles.dart';
import 'package:e_commerce_app/core/routes/app_router.dart';
import 'package:e_commerce_app/core/widgets/custom_elevatedbtn.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/email_text_field.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/password_text_field.dart';
import 'package:e_commerce_app/generated/assets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/service_locator_get_it.dart';


class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final GlobalKey<FormState> formKey =  GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

   Future<void> dispose(){

     emailController.dispose();
     passwordController.dispose();
     return Future.value(null);
   }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: formKey,
        child:SingleChildScrollView(
          child: SafeArea(
            child: Column(
            
              children: [
                // image in the top
               const SizedBox(height: 15,),
               Image.asset("assets/images/cart1.png",height: 250,width: 290,),



                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      // welcome text
                      Padding(
                        padding: const EdgeInsets.only(top:20.0,bottom: 35.0 ),
                        child: Text("   Welcome Back !",
                          style: AppTextStyles.poppins500style24.copyWith(fontWeight: FontWeight.w600,fontSize: 30.0),),
                      ),
                      //Email Field
                      CustomEmailTextField(emailController: emailController, color: AppColors.fontGrey),
                      const SizedBox(height: 25,),
                      //Password Field
                      CustomPasswordTextField(passwordController: passwordController, color:  AppColors.fontGrey),
                      const SizedBox(height: 15,),
                      //forgot password
                      Row(
                        children: [
                          const Spacer(),
                          InkWell(
                            onTap: (){
                              GoRouter.of(context).push(resetPasswordPath);
                            },
                            child: Text("Forgot Password ?",
                              style: AppTextStyles.poppins500style24.copyWith(color: AppColors.fontGrey,fontSize: 16.0),),
                          ),
                        ],
                      ),
                      const SizedBox(height: 50,),
                      //Login Button
            
                      BlocConsumer<AuthCubit, AuthState>(
                        listener: (context, state) {
                          if(state is SignSuccess)
                          {
                            if(FirebaseAuth.instance.currentUser!.emailVerified) {
                              GoRouter.of(context).pushReplacement(homePath);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Sign In Success"),backgroundColor: Colors.green,));
                            }else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Verify your account"),backgroundColor: Colors.red,));
                              FirebaseAuth.instance.signOut();
                            }
            
                          } else if(state is SignInFailure) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                          }
                        },
                        builder: (context, state) {
                          return state is SignInLoading ? const CircularProgressIndicator() :
                          CustomElevatedbtn(text: "Sign In", onPressed: ()async{
                            if(formKey.currentState!.validate()){

                              getIt<AuthCubit>().signInWithEmail(emailController.text, passwordController.text);
            
                            }
            
            
                          });
                        },
                      ),
                      const SizedBox(
                        height: 10,),
                      Text("---------------------- or continue with ----------------------"),
                      const SizedBox(
                        height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(onPressed: (){
                            getIt<AuthCubit>().signWithGoogle();
                          }, icon:Image.asset(Assets.imagesGoogle,width:60,height: 55,) ),
                          SizedBox(width: size.width*0.1,),
                          IconButton(onPressed: (){
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.info,
                              animType: AnimType.rightSlide,
                              title: 'OOPS!',
                              desc: 'This feature is not available yet',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {},
                            )..show();
                          }, icon: SvgPicture.asset(Assets.imagesFacebook)),
                        ],
                      ),


                      //Don't have an account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account ?",style: TextStyle(fontSize: 16.0),),
                          const SizedBox(width: 5,),
                          TextButton(onPressed: (){
                            GoRouter.of(context).pushReplacement(signUpPath);
                          }, child: const Text("Sign Up",style: TextStyle(color: AppColors.fontSecondaryColor,fontSize: 16.0),)),
                        ],
                      )
            
                    ],
                  ),
                ),
              ],
            ),
          ),
        ) ,
      ),
    );
  }
}
