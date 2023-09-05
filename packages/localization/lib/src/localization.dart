import 'package:flutter/material.dart';
import 'package:localization/src/ar.dart';
import 'package:localization/src/en.dart';

import 'enum.dart';

class Localization {
  static final Localization _instance = Localization.internal();

  Localization.internal();

  factory Localization() => _instance;

  LocalizationCode localizationCode = LocalizationCode.en;
  Map localizationMap = localizationMapEn;

  void setLang(LocalizationCode localizationCode) {
    if (localizationCode == LocalizationCode.en) {
      Localization().localizationMap = localizationMapEn;
      Localization().localizationCode = LocalizationCode.en;
    } else {
      Localization().localizationMap = localizationMapAr;
      Localization().localizationCode = LocalizationCode.ar;
    }
  }

  String get localizationCodeString {
    switch (localizationCode) {
      case LocalizationCode.ar:
        return "ar";
      case LocalizationCode.en:
        return "en";
    }
  }
}

extension AppLocalizationsX on BuildContext {
  String localization(String key) {
    return Localization().localizationMap[key] ?? key;
  }
}
