import 'package:localization/localization.dart';

class FontFamily {
  static final FontFamily _instance = FontFamily.internal();

  FontFamily.internal();

  factory FontFamily() => _instance;

  String normalFont = Localization().localizationMap['fontFamily'];
}
