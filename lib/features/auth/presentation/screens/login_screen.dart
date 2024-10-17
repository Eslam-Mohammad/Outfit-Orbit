
import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:e_commerce_app/core/constants/app_text_styles.dart';
import 'package:e_commerce_app/core/widgets/custom_elevatedbtn.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:e_commerce_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/email_text_field.dart';
import 'package:e_commerce_app/features/auth/presentation/widgets/password_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
  final GlobalKey<FormState> formKey =  GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: formKey,
        child:SingleChildScrollView(
          child: Column(
            
            children: [
               Container(
                height: 290,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color:AppColors.primary,
                ),
                  child: Stack(
                    children: [
                      Positioned(

                        top: 120,
                        left: size.width/2-40,
                        child: const Text("Dalel",
                          style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),),

                      ),
                      Positioned(
                        top: 188,
                        left: 0,
                        child: SvgPicture.asset("assets/images/pyramidsvec.svg"),
          
                      ),
                      Positioned(
                        top: 161,
                        right: 0,
                        child: SvgPicture.asset("assets/images/buildingvec.svg"),
          
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    // welcome text
                    Padding(
                      padding: const EdgeInsets.only(top:30.0,bottom: 40.0 ),
                      child: Text("Welcome Back !",
                        style: AppTextStyles.poppins500style24.copyWith(fontWeight: FontWeight.w600,fontSize: 30.0),),
                    ),
                    //Email Field
                    CustomEmailTextField(emailController: emailController, color: AppColors.primary),
                    const SizedBox(height: 25,),
                    //Password Field
                    CustomPasswordTextField(passwordController: passwordController, color: AppColors.primary),
                    const SizedBox(height: 15,),
                    //forget password
                    Row(
                      children: [
                        const Spacer(),
                        InkWell(
                          onTap: (){
                            GoRouter.of(context).pushReplacement("/resetPassword");
                          },
                          child: Text("Forgot Password ?",
                            style: AppTextStyles.poppins500style24.copyWith(color: AppColors.fontSecondaryColor,fontSize: 16.0),),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100,),
                    //Login Button
                    
                    BlocConsumer<AuthCubit, AuthState>(
                         listener: (context, state) {
                            if(state is SignInSuccess)
                            {
                              if(FirebaseAuth.instance.currentUser!.emailVerified) {
                                GoRouter.of(context).pushReplacement("/home");
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Sign In Success"),backgroundColor: Colors.green,));
                              }else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Verify your account"),backgroundColor: Colors.red,));
                                FirebaseAuth.instance.signOut();
                              }

                            } else if(state is SignInFailed) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                            }
                            },
                           builder: (context, state) {
                    return state is SignInLoading ? const CircularProgressIndicator() :
                      CustomElevatedbtn(text: "Sign In", onPressed: ()async{
                     if(formKey.currentState!.validate()){


                     }


                    });
  },
),
                    const SizedBox(
                      height: 15,),
                    //Don't have an account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account ?",style: TextStyle(fontSize: 16.0),),
                        const SizedBox(width: 5,),
                        TextButton(onPressed: (){
                          GoRouter.of(context).pushReplacement("/signup");
                        }, child: const Text("Sign Up",style: TextStyle(color: AppColors.primary,fontSize: 16.0),)),
                      ],
                    )
              
                  ],
                ),
              ),
            ],
          ),
        ) ,
      ),
    );
  }
}
