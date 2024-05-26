import 'package:cowpay/core/packages/screen_util/screen_util.dart';
import 'package:flutter/material.dart';

import '../../src/app_colors.dart';
import '../../src/text_styles.dart';

class ButtonView extends StatelessWidget {
  const ButtonView(
      {Key? key,
      this.backgroundColor,
      this.borderColor,
      this.textColor,
      required this.title,
      required this.onClickFunction,
      this.width,
      this.height,
      this.isEnabled = true,
      required this.mainContext,
      this.textScaleFactor = 1})
      : super(key: key);

  final Color? backgroundColor;
  final Color? borderColor, textColor;
  final String title;
  final void Function(BuildContext) onClickFunction;
  final double? width, height;
  final BuildContext mainContext;
  final double? textScaleFactor;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    double opacity = 0.5;
    Color color = isEnabled
        ? backgroundColor ?? AppColors.primary
        : backgroundColor?.withOpacity(opacity) ??
            AppColors.primary.withOpacity(opacity);

    return InkWell(
      onTap: isEnabled ? () => onClickFunction(mainContext) : null,
      child: Container(
          width: width ?? 0.9.sw,
          height: height ?? 0.06.sh,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color,
              border:
                  borderColor != null ? Border.all(color: borderColor!) : null,
              borderRadius: BorderRadius.all(Radius.circular(11.sp))),
          child: Text(
            title,
            style: TextStyles.appBarTitleTextStyle
                .copyWith(color: textColor ?? Colors.white, fontSize: 15.sp),
            // textScaleFactor: textScaleFactor!
            textScaler: TextScaler.linear(textScaleFactor!),
          )),
    );
  }
}
