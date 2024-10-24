import 'package:flutter/material.dart';

class CustomPasswordTextField extends StatelessWidget {
  const CustomPasswordTextField({super.key,required this.passwordController,required this.color}) ;
  final TextEditingController passwordController ;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value){
        if(value!.isEmpty||value.length<8){
          return 'Please enter your password';
        }
        return null;
      },

      obscureText: true,
      controller: passwordController,
      decoration: InputDecoration(
        labelStyle:  TextStyle(color: color),
        labelText: 'Password',
        prefixIcon:  Icon(Icons.lock,color: color,),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide:  BorderSide(color: color,width: 2.0),),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide:  BorderSide(color: color,width: 2.0),),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide:  BorderSide(color: color,width: 2.0),),

      ),
    );
  }
}
