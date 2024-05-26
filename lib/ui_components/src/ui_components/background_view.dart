import 'package:cowpay/core/packages/screen_util/screen_util.dart';
import 'package:flutter/material.dart';

import '../../ui_components.dart';
import 'app_bar_view.dart';

class BackgroundView extends StatelessWidget {
  final Widget contentWidget;
  final String? title;
  final Widget? appBarEndActions;
  final Widget? appBarStartActions;

  const BackgroundView({
    super.key,
    required this.contentWidget,
    this.title,
    this.appBarEndActions,
    this.appBarStartActions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        children: [
          AppBarView(
            title: title,
            appBarEndActions: appBarEndActions,
            appBarStartActions: appBarStartActions,
          ),
          Expanded(
            child: Container(
              width: 1.sw,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.only(
                    topStart: Radius.circular(20),
                    topEnd: Radius.circular(20),
                  )),
              padding: EdgeInsets.only(bottom: 0.01.sh, top: 0.0.sh),
              child: ClipRRect(
                borderRadius: const BorderRadiusDirectional.only(
                  topStart: Radius.circular(20),
                  topEnd: Radius.circular(20),
                ),
                child: SafeArea(
                  top: false,
                  child: contentWidget,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
