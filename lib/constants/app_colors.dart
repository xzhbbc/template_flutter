import 'package:flutter/material.dart';

class AppColors {
  static const Color themeColor = Color(0xFF6059DE);

  static const Color textColor = Color(0xFF333333);
  static const Color textColorB = Color(0xFFBBBBBB);
  static const Color textColorD = Color(0xFFDDDDDD);
  static const Color textColorSecondary = Color(0xFF999999);

  static const Color opcBlack005 = Color.fromRGBO(0, 0, 0, 0.05);
  static const Color failText = Color(0xFFFF5D4D);
  static const Color borderColor = Color(0xFFEEEEEE);
  static const Color forgetColor = Color(0xFF0077FF);

  static const footShadow = [
     BoxShadow(
        color: AppColors.opcBlack005,
        offset: Offset(0, -1),
        blurRadius: 3.0,
        spreadRadius: 0)
  ];
}