import 'package:flutter/material.dart';

import 'constant.dart';
class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
  FontWeight? fontWeight;
   Color? color ;
  CustomText({
    required this.text,
    required this.fontSize,
     this.color,
    this.fontWeight

});

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(
        wordSpacing: 3,
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,


      ),
    );
  }
}
