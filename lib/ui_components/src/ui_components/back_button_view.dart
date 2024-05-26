import 'package:cowpay/core/packages/screen_util/screen_util.dart';
import 'package:cowpay/localization/src/localization.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../core/packages/flutter_svg/flutter_svg.dart';
import '../../ui_components.dart';

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
