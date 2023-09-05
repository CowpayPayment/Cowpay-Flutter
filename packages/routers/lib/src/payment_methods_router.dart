import 'package:flutter/material.dart';
import 'package:payment_methods/payment_methods.dart';

class PaymentMethodsRouter {
  PaymentMethodsRouter._();

  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case PaymentMethodsScreen.id:
        return MaterialPageRoute(builder: (_) => PaymentMethodsScreen());

      default:
        return null;
    }
  }
}

class PaymentMethodsScreens {
  PaymentMethodsScreens._();

  static String paymentMethodsScreenId = PaymentMethodsScreen.id;
}
