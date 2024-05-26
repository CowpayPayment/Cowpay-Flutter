import 'package:flutter/material.dart';

import '../../features/fawry_payment/src/fawry_payment_presentation/fawry_payment_ui/screens/fawry_screen.dart';

class FawryRouter {
  FawryRouter._();

  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case FawryScreen.id:
        return MaterialPageRoute(builder: (_) => const FawryScreen());

      default:
        return null;
    }
  }
}

class FawryScreens {
  FawryScreens._();

  static String fawryScreenId = FawryScreen.id;
}
