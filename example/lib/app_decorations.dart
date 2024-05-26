import 'package:flutter/material.dart';

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
    Color? erroBorderColor,
    double? erroBorderThickness,
  }) =>
      InputDecoration(
        counterText: "",
        labelStyle: labelTextStyle ??
            const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 13.0,
            ),
        prefixIconConstraints:
            const BoxConstraints(minHeight: 20, minWidth: 20),
        prefixIcon: prefixIcon,
        contentPadding: isDense == null
            ? const EdgeInsets.symmetric(horizontal: 10, vertical: 8)
            : const EdgeInsets.all(8),
        suffixIcon: suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            width: focusedBorderThickness ?? 1,
            color: focusedBorderColor ?? Colors.grey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            width: enabledBorderThickness ?? 1,
            color: enabledBorderColor ?? Colors.grey.withOpacity(0.3),
          ),
        ),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              width: enabledBorderThickness ?? 1,
              color: enabledBorderColor ??
                  Colors.grey.withOpacity(
                    0.3,
                  ),
            )),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            width: erroBorderThickness ?? 2,
            color: erroBorderColor ?? Colors.red,
          ),
        ),
        errorStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w500,
          fontSize: 13.0,
        ).copyWith(color: Colors.grey),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            width: erroBorderThickness ?? 2,
            color: erroBorderColor ?? Colors.red,
          ),
        ),
        // errorStyle: AppTextsStyles.appTextFieldErrorStyle,
        hintText: hint,
        labelText: label,
        hintStyle: hintTextStyle ??
            const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 13.0,
            ),
        fillColor: fillColor ?? Colors.white,
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
        // AppColors.orangeyRed.withOpacity(0.12),
        // AppColors.goldenrod.withOpacity(0.087),
        Color.fromRGBO(254, 243, 239, 1.0),
        Color.fromRGBO(255, 249, 237, 1),
      ],
    ),
  );
  static BoxDecoration tabBarDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
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
