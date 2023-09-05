import 'package:core/packages/flutter_svg/flutter_svg.dart';
import 'package:core/packages/screen_util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../ui_components.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {Key? key,
      this.formatters,
      this.controller,
      this.hintKey,
      this.labelKey,
      this.validator,
      this.onChanged,
      this.textInputType,
      this.initialValue,
      this.textInputAction,
      this.onFieldSubmitted,
      this.margin,
      this.suffixIcon,
      this.prefixIcon,
      this.enabled = true,
      this.onUserTap,
      this.maxLines,
      this.fillColor,
      this.isDense,
      this.hintTextStyle,
      this.height,
      this.cornerRadius = 24,
      this.textStyle,
      this.focusedBorderColor = AppColors.secondary,
      this.focusedBorderThickness,
      this.enabledBorderColor = AppColors.secondary,
      this.enabledBorderThickness,
      this.errorBorderColor = AppColors.errorColor,
      this.errorBorderThickness,
      this.obscureText = false,
      this.focusNode,
      this.labelTextStyle,
      this.maxLength})
      : super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintKey;
  final String? labelKey;
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final Function(String value)? onChanged;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final EdgeInsetsDirectional? margin;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool enabled;
  final VoidCallback? onUserTap;
  final int? maxLines;
  final Color? fillColor;
  final bool? isDense;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final TextStyle? textStyle;
  final double cornerRadius;
  final Color? focusedBorderColor;
  final double? focusedBorderThickness;
  final Color? enabledBorderColor;
  final double? enabledBorderThickness;
  final Color? errorBorderColor;
  final double? errorBorderThickness;
  final int? maxLength;
  final bool obscureText;
  final double? height;
  final List<TextInputFormatter>? formatters;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onUserTap,
      child: Container(
        margin: margin,
        child: Column(
          children: [
            TextFormField(
              inputFormatters: formatters,
              focusNode: focusNode,
              obscureText: obscureText,
              maxLength: maxLength,
              controller: controller,
              maxLines: maxLines ?? 1,
              validator: validator,
              keyboardType:
                  (maxLines ?? 0) > 1 ? TextInputType.multiline : textInputType,
              enabled: enabled,
              initialValue: initialValue,
              onChanged: onChanged,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              style: textStyle ??
                  (enabled
                      ? TextStyles.appTextFieldStyle
                      : TextStyles.appTextFieldStyle
                          .copyWith(color: AppColors.hintGrey)),
              decoration: AppDecorations.inputTextDecoration(
                prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.sp),
                  child: prefixIcon,
                ),
                suffixIcon: suffixIcon,
                fillColor: fillColor,
                hint: hintKey,
                label: labelKey,
                isDense: isDense,
                hintTextStyle: hintTextStyle ??
                    TextStyle(
                      fontFamily: FontFamily().normalFont,
                      color: AppColors.primary.withOpacity(0.5),
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                labelTextStyle: labelTextStyle ??
                    TextStyle(
                      fontFamily: FontFamily().normalFont,
                      color: AppColors.primary.withOpacity(0.5),
                      fontSize: 12.sp,
                    ),
                cornerRadius: cornerRadius,
                focusedBorderColor: AppColors.primary,
                focusedBorderThickness: focusedBorderThickness,
                enabledBorderColor: AppColors.primary.withOpacity(0.3),
                enabledBorderThickness: enabledBorderThickness,
                erroBorderColor: AppColors.errorColor,
                erroBorderThickness: errorBorderThickness,
              ),
              cursorColor: AppColors.primary,
              textInputAction: textInputAction ?? TextInputAction.next,
              onFieldSubmitted: onFieldSubmitted,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMainFormTextField({
    required FieldData fieldData,
    bool isEnable = true,
    bool obscureText = false,
    String? value,
    FormFieldValidator<String>? validator,
    Function(String value)? onChange,
    TextInputAction? textInputAction,
    TextInputType? textInputType,
    int? maxLength,
    Function? onPressSuffixIcon,
    Function()? onPress,
    TextEditingController? controller,
    List<TextInputFormatter>? formatters,
  }) {
    return SizedBox(
      child: InkWell(
        onTap: onPress,
        child: AppTextField(
          margin: EdgeInsetsDirectional.symmetric(
              horizontal: 10.sp, vertical: 5.sp),
          formatters: formatters,
          initialValue: value,
          maxLines: 1,
          maxLength: maxLength,
          onChanged: onChange,
          obscureText: obscureText,
          controller: controller,
          labelKey: fieldData.lable,
          enabled: isEnable,
          hintKey: fieldData.hint,
          fillColor: Colors.transparent,
          // focusNode: fieldData.focusNode,
          labelTextStyle: TextStyle(
            fontFamily: FontFamily().normalFont,
            color: AppColors.primary.withOpacity(0.5),
            fontSize: 12.sp,
          ),
          validator: validator,
          textInputAction: textInputAction ?? TextInputAction.next,
          textInputType: textInputType ?? TextInputType.text,
          prefixIcon: Padding(
            padding: EdgeInsetsDirectional.all(5.sp),
            child: SizedBox(
                width: 20.sp,
                height: 20.sp,
                child: SvgPicture.asset(
                  fieldData.prefixIconPath,
                  package: 'cowpay',
                )),
          ),

          suffixIcon:
              (fieldData.suffixIconPath != null && onPressSuffixIcon != null)
                  ? InkWell(
                      onTap: () {
                        onPressSuffixIcon();
                      },
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                            start: 10.sp,
                            end: 15.sp,
                            top: 18.sp,
                            bottom: 10.sp),
                        child: SizedBox(
                          width: 20.sp,
                          height: 20.sp,
                          child: SvgPicture.asset(
                            fieldData.suffixIconPath!,
                            package: 'cowpay',
                          ),
                        ),
                      ),
                    )
                  : null,
        ),
      ),
    );
  }
}

class FieldData {
  final String lable;
  final String prefixIconPath;
  final String? suffixIconPath;
  final String? hint;

  const FieldData({
    required this.lable,
    required this.prefixIconPath,
    this.suffixIconPath,
    this.hint,
  });
}
