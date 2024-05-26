import 'package:flutter/material.dart';

import '../../features/payment_methods/payment_methods.dart';
import '../routers.dart';

class AppRouter {
  AppRouter._();

  static Route onGenerateRoute(RouteSettings routeSettings) {
    return PaymentMethodsRouter.onGenerateRoute(routeSettings) ??
        CardPaymentRouter.onGenerateRoute(routeSettings) ??
        FawryRouter.onGenerateRoute(routeSettings) ??
        MaterialPageRoute(builder: (_) => const PaymentMethodsScreen());
  }
}
