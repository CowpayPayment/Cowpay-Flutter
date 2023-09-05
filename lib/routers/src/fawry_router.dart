import 'package:flutter/material.dart';

import '../../features/fawry_payment/fawry_payment.dart';

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
