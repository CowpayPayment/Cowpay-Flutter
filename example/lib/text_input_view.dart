import 'package:flutter/material.dart';

import 'app_decorations.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {Key? key,
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
      this.focusedBorderColor = Colors.grey,
      this.focusedBorderThickness,
      this.enabledBorderColor = Colors.grey,
      this.enabledBorderThickness,
      this.errorBorderColor = Colors.red,
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onUserTap,
      child: Container(
        margin: margin,
        child: Column(
          children: [
            TextFormField(
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
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 13.0,
              ),
              decoration: AppDecorations.inputTextDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: prefixIcon,
                ),
                suffixIcon: suffixIcon,
                fillColor: fillColor,
                hint: hintKey,
                label: labelKey,
                isDense: isDense,
                hintTextStyle: hintTextStyle ??
                    const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.0,
                    ),
                labelTextStyle: labelTextStyle ??
                    const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 13.0,
                    ),
                cornerRadius: cornerRadius,
                focusedBorderColor: Colors.grey,
                focusedBorderThickness: focusedBorderThickness,
                enabledBorderColor: Colors.grey,
                enabledBorderThickness: enabledBorderThickness,
                erroBorderColor: Colors.red,
                erroBorderThickness: errorBorderThickness,
              ),
              cursorColor: Colors.black,
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
  }) {
    return SizedBox(
      child: InkWell(
        onTap: onPress,
        child: AppTextField(
          margin: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 5),
          initialValue: value,
          maxLines: 1,
          maxLength: maxLength,
          onChanged: onChange,
          obscureText: obscureText,
          controller: controller,
          labelKey: fieldData.label,
          enabled: isEnable,
          hintKey: fieldData.hint,
          fillColor: Colors.transparent,
          // focusNode: fieldData.focusNode,
          labelTextStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 13.0,
          ),
          validator: validator,
          textInputAction: textInputAction ?? TextInputAction.next,
          textInputType: textInputType ?? TextInputType.text,
        ),
      ),
    );
  }
}

class FieldData {
  final String label;
  final String? prefixIconPath;
  final String? suffixIconPath;
  final String? hint;

  const FieldData({
    required this.label,
    this.prefixIconPath,
    this.suffixIconPath,
    this.hint,
  });
}
