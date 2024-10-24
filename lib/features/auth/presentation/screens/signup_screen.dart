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
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../../../core/services/service_locator_get_it.dart';
import '../widgets/custom_name_text_field.dart';



class SignUpScreen extends StatefulWidget {
   const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
 final GlobalKey<FormState> formKey =  GlobalKey<FormState>();

 final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

 @override
 void dispose() {
   firstNameController.dispose();
   lastNameController.dispose();
   emailController.dispose();
   passwordController.dispose();
   super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  //Welcome Text
                  Padding(
                    padding: const EdgeInsets.only(top:100 ),
                    child: Text("Welcome !",
                    style: AppTextStyles.poppins500style24.copyWith(fontWeight: FontWeight.w600,fontSize: 30.0),),
                  ),
                  const SizedBox(height: 40,),

                  //First Name Field
                  CustomNameTextField(NameController: firstNameController, color: AppColors.fontGrey, identifyName: "First"),
                  const SizedBox(height: 25,),

                  //Last Name Field
                  CustomNameTextField(NameController: lastNameController, color: AppColors.fontGrey, identifyName: "Last"),
                  const SizedBox(height: 25,),

                  //Email Field
                  CustomEmailTextField(emailController: emailController, color: AppColors.fontGrey),
                  const SizedBox(height: 25,),

                  //Password Field
                  CustomPasswordTextField(passwordController: passwordController, color: AppColors.fontGrey),
                  const SizedBox(height: 25,),


                  //Terms and Conditions
                  BlocBuilder<AuthCubit, AuthState>(
                   builder: (context, state) {
                         return Row(
                    children: [
                      Checkbox(value:getIt<AuthCubit>().isAgreed??false, onChanged: (value){
                        getIt<AuthCubit>().agreeToTerms(value!);
                      }),
                      const SizedBox(width: 10,),
                      const Text("I agree to the terms and conditions",
                      ),
                    ],
                  );
  },
),
                  const SizedBox(height: 60,),

                  BlocConsumer<AuthCubit,AuthState>(
                      builder: (context, state){

                        return state is SignUpLoading?
                        const CircularProgressIndicator(color: AppColors.primary,):
                        CustomElevatedbtn(text: "Sign Up", onPressed: (){
                          if(formKey.currentState!.validate()&&getIt<AuthCubit>().isAgreed!) {

                            getIt<AuthCubit>().signUpWithEmail(emailController.text, passwordController.text,firstNameController.text+" "+lastNameController.text);


                          }

                        }) ;

                      },
                      listener: (context, state)async{
                        if(state is SignUpSuccess){

                          GoRouter.of(context).pushReplacement(loginPath);
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Verify your account"),backgroundColor: Colors.red,));
                          await FirebaseAuth.instance.signOut();
                        }else if (state is SignUpFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message),backgroundColor: Colors.red,));
                        }

                      },
                  ),

                  //Sign Up Button






                  const SizedBox(
                    height: 8,),
                  const Text("---------------------- or continue with ----------------------"),
                  const SizedBox(
                    height: 8,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(onPressed: ()async{
                        getIt<AuthCubit>().signInWithGoogle();
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
                        ).show();
                      }, icon: SvgPicture.asset(Assets.imagesFacebook)),
                    ],
                  ),


                  //Already have an account
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?",style: TextStyle(fontSize: 16.0),),
                      const SizedBox(width: 5,),
                       TextButton(onPressed: (){
                        GoRouter.of(context).pushReplacement(loginPath);
                      }, child: const Text("Sign In",style: TextStyle(color: AppColors.fontSecondaryColor,fontSize: 16.0),)),
                    ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}





















