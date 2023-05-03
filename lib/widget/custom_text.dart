import 'package:flutter/material.dart';

import 'constant.dart';
class CustomText extends StatelessWidget {
  final String text;
  final double fontSize;
   Color? color ;
  CustomText({
    required this.text,
    required this.fontSize,
     this.color
});

  @override
  Widget build(BuildContext context) {
    return Text(text,
      style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,

      ),
    );
  }
}
