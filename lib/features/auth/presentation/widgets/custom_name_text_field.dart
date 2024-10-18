import 'package:flutter/material.dart';

class CustomNameTextField extends StatelessWidget {
  final TextEditingController NameController ;
  final Color color;
  final String identifyName;
   CustomNameTextField({super.key, required this.color, required this.NameController, required this.identifyName});

  @override
  Widget build(BuildContext context) {
    return  TextFormField(
      validator: (value){
        if(value!.isEmpty){
          return 'Please enter your $identifyName name';
        }
        return null;
      },
      controller: NameController,
      decoration: InputDecoration(
        focusColor: color,
        labelStyle:  TextStyle(color: color),
        labelText: "$identifyName Name",

        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide:BorderSide(color:color,width: 2.0),),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide:  BorderSide(color: color,width: 2.0),),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide:  BorderSide(color:color,width: 2.0),),

      ),
    );
  }
}
