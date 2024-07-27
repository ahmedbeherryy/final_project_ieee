import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({ this.color,required this.width,this.onTap,super.key,required this.buttomText});

   VoidCallback? onTap;
  String buttomText;
  double width;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(color:color,child: Center(child: Text(buttomText)),
        width: width,
        height: 40,
        decoration:BoxDecoration(borderRadius:BorderRadius.circular(11),
          color:Colors.white,
        ),
      ),
    );
  }
}
