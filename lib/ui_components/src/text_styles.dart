import 'package:cowpay/core/packages/screen_util/screen_util.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'font_family.dart';

class TextStyles {
  TextStyles._();

  static TextStyle bodyTextStyle = TextStyle(
      fontFamily: FontFamily().normalFont,
      color: AppColors.white,
      fontSize: 12.sp,
      package: 'cowpay',
      fontWeight: FontWeight.normal);

  static TextStyle appBarTitleTextStyle = TextStyle(
      fontFamily: FontFamily().normalFont,
      color: AppColors.white,
      fontSize: 17.sp,
      package: 'cowpay',
      fontWeight: FontWeight.w600);

  static TextStyle appTextFieldStyle = TextStyle(
    color: AppColors.primary,
    fontFamily: FontFamily().normalFont,
    fontWeight: FontWeight.w500,
    package: 'cowpay',
    fontSize: 13.0.sp,
  );
  static TextStyle hintTextStyle = TextStyle(
    color: AppColors.primary.withOpacity(0.3),
    fontWeight: FontWeight.w400,
    fontFamily: FontFamily().normalFont,
    package: 'cowpay',
    fontSize: 12.0.sp,
  );
}
