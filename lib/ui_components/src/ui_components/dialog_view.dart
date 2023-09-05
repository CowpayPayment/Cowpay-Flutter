import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../src/enums.dart';
import '../../ui_components.dart';
import 'button_view.dart';

class DialogView extends StatelessWidget {
  final String? content, secondButtonText, mainButtonText;
  final Widget? contentWidget;
  final Function(BuildContext)? onMainActionFunction, onSecondaryActionFunction;
  final DialogType dialogType;
  final bool isCloseIcon;
  final bool? isDismissible;

  const DialogView(
      {Key? key,
      this.content,
      this.contentWidget,
      this.isCloseIcon = false,
      this.isDismissible = true,
      this.secondButtonText,
      this.onMainActionFunction,
      required this.dialogType,
      this.onSecondaryActionFunction,
      this.mainButtonText = 'close'})
      : super(key: key);

  static showBottomSheet({
    required BuildContext context,
    required WidgetBuilder builder,
    bool isDismissible = true,
  }) {
    showModalBottomSheet(
        isDismissible: isDismissible,
        enableDrag: isDismissible,
        shape: const RoundedRectangleBorder(
          // <-- SEE HERE
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        context: context,
        builder: builder);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(isDismissible),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25.sp),
        child: Stack(
          children: [
            Positioned(
              right: 0,
              left: 0,
              top: 0,
              bottom: 0,
              child: SizedBox(
                height: 0.4.sh,
                width: 1.0.sw,
                // decoration: BoxDecoration(
                //   // borderRadius: const BorderRadius.all(Radius.circular(20)),
                //   gradient: LinearGradient(
                //     begin: Alignment.topCenter,
                //     end: Alignment.bottomCenter,
                //     colors: [dialogType.gradiantColor, AppColors.white],
                //   ),
                // ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  // height: 0.3.sh,
                  child: Stack(
                    children: [
                      Container(
                        alignment: AlignmentDirectional.topCenter,
                        padding: EdgeInsets.only(top: 0.03.sh),
                        child: SvgPicture.asset(
                          dialogType.image,
                          package: 'cowpay',
                        ),
                      ),
                      if (isCloseIcon == true)
                        PositionedDirectional(
                          start: 15.sp,
                          top: 20.sp,
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                                // padding: EdgeInsets.all(10.sp),
                                alignment: AlignmentDirectional.topStart,
                                child: Icon(
                                  CupertinoIcons.clear_circled,
                                  color: Colors.grey.withOpacity(0.9),
                                )),
                          ),
                        )
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 0.03.sw, vertical: 8.sp),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          if (content != null)
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 0.04.sw),
                              child: Text(
                                content!,
                                textAlign: TextAlign.center,
                                style: TextStyles.appBarTitleTextStyle.copyWith(
                                    color: Colors.black, fontSize: 16.sp),
                              ),
                            ),
                          if (contentWidget != null)
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 0.04.sw),
                              child: contentWidget,
                            ),
                          SizedBox(
                            height: 0.05.sh,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (secondButtonText != null &&
                              onSecondaryActionFunction != null)
                            ButtonView(
                              textColor: dialogType.color,
                              title: secondButtonText!,
                              onClickFunction: onSecondaryActionFunction!,
                              mainContext: context,
                              width: (mainButtonText != null &&
                                      onMainActionFunction != null)
                                  ? 0.45.sw
                                  : 0.9.sw,
                              backgroundColor: dialogType.secondColor,
                              borderColor: dialogType.color,
                            ),
                          if (secondButtonText != null &&
                              onSecondaryActionFunction != null)
                            const Expanded(child: SizedBox()),
                          if (mainButtonText != null &&
                              onMainActionFunction != null)
                            ButtonView(
                                backgroundColor: dialogType.color,
                                title: mainButtonText!,
                                onClickFunction: onMainActionFunction!,
                                width: (secondButtonText != null &&
                                        onSecondaryActionFunction != null)
                                    ? 0.45.sw
                                    : 0.9.sw,
                                mainContext: context),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DrawTriangleShape extends CustomPainter {
  Paint? painter;

  DrawTriangleShape() {
    painter = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.moveTo(size.width, 0);
    path.lineTo(0, 0);
    path.lineTo(size.width / 2, size.height);
    path.close();

    canvas.drawPath(path, painter!);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CircleBlurPainter extends CustomPainter {
  CircleBlurPainter({required this.circleWidth, required this.blurSigma});

  double circleWidth;
  double blurSigma;

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = Colors.lightBlue
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
