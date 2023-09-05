import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../app_colors.dart';

class ButtonLoadingView extends StatelessWidget {
  final double? width;
  final double? height;
  final double? strokeWidth;
  const ButtonLoadingView(
      {super.key, this.height, this.width, this.strokeWidth});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 0.14.sw,
      height: height ?? 0.14.sw,
      child: SpinKitFadingCircle(
        color: AppColors.primary,
        size: width ?? 0.14.sw,
      ),
    );
  }
}
