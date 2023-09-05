import 'package:core/core.dart';
import 'package:core/packages/flutter_svg/flutter_svg.dart';
import 'package:core/packages/screen_util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:ui_components/src/app_assets.dart';

class BackButtonView extends StatelessWidget {
  final Function? onTap;

  const BackButtonView({this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        } else {
          Navigator.of(GlobalVariables().pluginContext).pop();
        }
      },
      child: Row(
        children: [
          RotatedBox(
            quarterTurns:
                int.tryParse(context.localization('quarterTurns')) ?? 0,
            child: SvgPicture.asset(
              AppAssets.backButtonIcon,
              package: 'cowpay',
              width: 10.sp,
            ),
          ),
          SizedBox(
            width: 10.sp,
          ),
          Image.asset(
            AppAssets.cowpayAppBarLogo,
            height: 25.sp,
            package: 'cowpay',
          )
        ],
      ),
    );
  }
}
