
import 'package:e_commerce_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomEmailTextField extends StatelessWidget {
  const CustomEmailTextField({super.key,required this.emailController ,required this.color});
   final TextEditingController emailController;
   final Color color;
  @override
  Widget build(BuildContext context) {
    return TextFormField(


      validator: (value){
        if(value!.isEmpty||value.contains('@')==false||value.contains('.com')==false){
          return 'Please enter your email';
        }
        return null;
      },

      controller: emailController,
      decoration: InputDecoration(

        labelStyle:  TextStyle(color:  color),
        labelText: 'Email',
        prefixIcon:  Icon(Icons.email,color: color,),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide:  BorderSide(color:  color,width: 2.0),),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide:  BorderSide(color:  color,width: 2.0),),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide:  BorderSide(color:   color,width: 2.0),),

      ),
    );
  }
}


