import 'package:core/packages/screen_util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../ui_components.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.sh,
      width: 1.sw,
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: SizedBox(
                width: 0.1.sw,
                height: 0.1.sw,
                child: const SpinKitFadingCircle(color: AppColors.primary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
