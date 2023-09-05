import 'package:flutter/material.dart';
import 'package:payment_methods/payment_methods.dart';
import 'package:routers/routers.dart';
import 'package:card_payment/card_payment.dart';

class AppRouter {
  AppRouter._();

  static Route onGenerateRoute(RouteSettings routeSettings) {
    return PaymentMethodsRouter.onGenerateRoute(routeSettings) ??
        CardPaymentRouter.onGenerateRoute(routeSettings) ??
        FawryRouter.onGenerateRoute(routeSettings) ??
        MaterialPageRoute(builder: (_) => PaymentMethodsScreen());
  }
}
