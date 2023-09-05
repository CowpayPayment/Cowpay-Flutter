import 'package:flutter/material.dart';

import 'app_assets.dart';
import 'app_colors.dart';

enum DialogType { infoDialog, successDialog, warningDialog, errorDialog }

extension DialogTypeExtension on DialogType {
  Color get color {
    switch (this) {
      case DialogType.infoDialog:
        return AppColors.primary;
      case DialogType.successDialog:
        return AppColors.successColor;
      case DialogType.warningDialog:
        return AppColors.warningColor;
      case DialogType.errorDialog:
        return AppColors.errorColor;
      default:
        return AppColors.warningColor;
    }
  }

  Color get secondColor {
    switch (this) {
      case DialogType.infoDialog:
        return AppColors.white;
      case DialogType.successDialog:
        return AppColors.white;
      case DialogType.warningDialog:
        return AppColors.white;
      case DialogType.errorDialog:
        return AppColors.white;
      default:
        return AppColors.white;
    }
  }

  String get image {
    switch (this) {
      case DialogType.infoDialog:
        return AppAssets.infoSign;
      case DialogType.warningDialog:
        return AppAssets.warningSign;
      case DialogType.errorDialog:
        return AppAssets.errorSign;
      case DialogType.successDialog:
        return AppAssets.successSign;
      default:
        return AppAssets.successSign;
    }
  }
}
