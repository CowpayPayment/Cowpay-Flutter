import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ui_components.dart';

class AppBarView extends StatelessWidget {
  final String? title;
  final Widget? appBarEndActions;
  final Widget? appBarStartActions;

  const AppBarView({
    super.key,
    required this.title,
    this.appBarEndActions,
    this.appBarStartActions,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            Positioned.fill(
              child: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (title != null)
                      Text(
                        title!,
                        style: TextStyles.appBarTitleTextStyle,
                      ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Container(
                height: 0.08.sh,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (appBarStartActions != null) appBarStartActions!,
                      if (appBarEndActions != null) appBarEndActions!,
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Container(
          width: 0.15.sw,
        )
      ],
    );
  }
}
