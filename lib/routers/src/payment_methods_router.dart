import 'package:flutter/material.dart';

import '../../features/payment_methods/payment_methods.dart';

class PaymentMethodsRouter {
  PaymentMethodsRouter._();

  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case PaymentMethodsScreen.id:
        return MaterialPageRoute(builder: (_) => const PaymentMethodsScreen());

      default:
        return null;
    }
  }
}

class PaymentMethodsScreens {
  PaymentMethodsScreens._();

  static String paymentMethodsScreenId = PaymentMethodsScreen.id;
}
