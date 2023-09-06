import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../ui_components.dart';

class AppDecorations {
  static InputDecoration inputTextDecoration({
    String? hint,
    String? label,
    Widget? suffixIcon,
    Widget? prefixIcon,
    Color? fillColor,
    bool? isDense,
    double cornerRadius = 24,
    TextStyle? hintTextStyle,
    TextStyle? labelTextStyle,
    Color? focusedBorderColor,
    double? focusedBorderThickness,
    Color? enabledBorderColor,
    double? enabledBorderThickness,
    Color? errorBorderColor,
    double? errorBorderThickness,
  }) =>
      InputDecoration(
        counterText: "",
        labelStyle: labelTextStyle ?? TextStyles.appTextFieldStyle,
        prefixIconConstraints:
            const BoxConstraints(minHeight: 20, minWidth: 20),
        prefixIcon: prefixIcon,
        contentPadding: isDense == null
            ? EdgeInsets.symmetric(horizontal: 10.sp, vertical: 8.sp)
            : const EdgeInsets.all(8),
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.sp),
          borderSide: BorderSide(
            width: focusedBorderThickness ?? 1.sp,
            color: focusedBorderColor ?? AppColors.primary,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.sp),
          borderSide: BorderSide(
            width: enabledBorderThickness ?? 1.sp,
            color: enabledBorderColor ?? AppColors.primary.withOpacity(0.3),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.sp),
          borderSide: BorderSide(
            width: enabledBorderThickness ?? 1.sp,
            color: enabledBorderColor ?? AppColors.primary.withOpacity(0.3),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.sp),
          borderSide: BorderSide(
            width: errorBorderThickness ?? 2.sp,
            color: errorBorderColor ?? AppColors.errorColor,
          ),
        ),
        errorStyle:
            TextStyles.bodyTextStyle.copyWith(color: AppColors.errorColor),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0.sp),
          borderSide: BorderSide(
            width: errorBorderThickness ?? 2.sp,
            color: errorBorderColor ?? AppColors.errorColor,
          ),
        ),
        // errorStyle: AppTextsStyles.appTextFieldErrorStyle,
        hintText: hint,
        labelText: label,
        hintStyle: hintTextStyle ?? TextStyles.hintTextStyle,
        fillColor: fillColor ?? AppColors.white,
        focusColor: Colors.black,
        filled: true,
        alignLabelWithHint: true,
        isDense: isDense,
      );

  static BoxDecoration screenGradientBackground = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment(0.5, 0),
      end: Alignment(0.5, 1),
      colors: [
        Color.fromRGBO(254, 243, 239, 1.0),
        Color.fromRGBO(255, 249, 237, 1),
      ],
    ),
  );
  static BoxDecoration tabBarDecoration = BoxDecoration(
    color: AppColors.white,
    borderRadius: BorderRadius.circular(12.r),
    gradient: const LinearGradient(
      colors: [
        // Color(0x52F04E37),
        // Color(0x22FBBC0F),
        Color.fromRGBO(252, 217, 210, 1),
        Color.fromRGBO(253, 230, 205, 1),
      ],
    ),
  );
}
