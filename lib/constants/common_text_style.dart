import 'package:flutter/material.dart';
import 'package:template_flutter/constants/app_colors.dart';

// 文字大小
class FontSizeSp {
  static num size8 = 8.0;
  static num size9 = 9.0;
  static num size10 = 10.0;
  static num size11 = 11.0;
  static num size12 = 12.0;
  static num size13 = 13.0;
  static num size14 = 14.0;
  static num size15 = 15.0;
  static num size16 = 16.0;
  static num size17 = 17.0;
  static num size18 = 18.0;
  static num size19 = 19.0;
  static num size20 = 20.0;
  static num size22 = 22.0;
  static num size24 = 24.0;
  static num size25 = 25.0;
  static num size28 = 28.0;
  static num size30 = 30.0;
  static num size36 = 36.0;
  static num size40 = 40.0;
}

// 普通字体命名规则： text（字体大小）With（字体颜色）（字体粗细）
final defaultText14 = TextStyle(
  fontSize: FontSizeSp.size14,
  color: AppColors.textColor,
  fontWeight: FontWeight.w400
);

final defaultText15 = TextStyle(
    fontSize: FontSizeSp.size15,
    color: AppColors.textColor,
    fontWeight: FontWeight.w400
);

final themeText14 = TextStyle(
    fontSize: FontSizeSp.size14,
    color: AppColors.themeColor,
    fontWeight: FontWeight.w400);

final themeText15 = TextStyle(
    fontSize: FontSizeSp.size15,
    color: AppColors.themeColor,
    decoration: TextDecoration.none,
    fontWeight: FontWeight.w400);

final text14WithFail = TextStyle(
  fontSize: FontSizeSp.size14,
  color: AppColors.failText,
  fontWeight: FontWeight.w400
);

final text14WithFailBold = TextStyle(
    fontSize: FontSizeSp.size14,
    color: AppColors.failText,
    fontWeight: FontWeight.bold
);

final text14WithFail600 = TextStyle(
    fontSize: FontSizeSp.size14,
    color: AppColors.failText,
    fontWeight: FontWeight.w600
);

final text15WithFail = TextStyle(
    fontSize: FontSizeSp.size15,
    color: AppColors.failText,
    fontWeight: FontWeight.w400);

final text14With9 = TextStyle(
    fontSize: FontSizeSp.size14,
    color: AppColors.textColorSecondary,
    decoration: TextDecoration.none);

final text16WithForget = TextStyle(
    fontSize: FontSizeSp.size16,
    color: AppColors.forgetColor,
    decoration: TextDecoration.none,
    fontWeight: FontWeight.w400);

final defaultText16 = TextStyle(
    fontSize: FontSizeSp.size16,
    color: AppColors.textColor,
    decoration: TextDecoration.none,
    fontWeight: FontWeight.w400);

final text14WithWhite = TextStyle(
    fontSize: FontSizeSp.size14,
    color: Colors.white,
    decoration: TextDecoration.none,
    fontWeight: FontWeight.w400);

final text16WithB = TextStyle(
    fontSize: FontSizeSp.size16,
    color: AppColors.textColorB,
    fontWeight: FontWeight.w400);