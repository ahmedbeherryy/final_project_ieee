import 'package:flutter/material.dart';

class CustomFormTextField extends StatelessWidget {
   CustomFormTextField({this.onChange,super.key, this.hintText});

   bool shoPass=false;
   Function(String)? onChange;   //بترجع استرينج
  String? hintText;
  @override
  Widget build(BuildContext context) {
    if(hintText =='Password')
      {
        shoPass=true;
      }
    return TextFormField(
      obscureText: shoPass,
      validator: (data)
      {
        if(data!.isEmpty){
          return 'Field is required';
        }
      },
      onChanged:onChange ,
    decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
    ),
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.white),
    border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white)),
    ),
    );
  }
}
