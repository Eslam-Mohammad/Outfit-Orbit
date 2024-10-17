import 'package:flutter/material.dart';

class CustomLoginButton extends StatelessWidget {
  const CustomLoginButton({super.key,required this.backgroundColor,required this.formKey,required this.onPressed});

  final Color backgroundColor;
  final GlobalKey<FormState> formKey;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child:  MaterialButton(
        onPressed: onPressed,
        child: const Text('LOGIN',style: TextStyle(color: Colors.white,fontSize: 20.0),),
      ),
    );
  }
}
