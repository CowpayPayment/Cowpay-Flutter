import 'package:cowpay/domain_models/domain_models.dart';
import 'package:flutter/material.dart';

import '../../features/card_payment/card_payment.dart';

class CardPaymentRouter {
  CardPaymentRouter._();

  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AddCardScreen.id:
        return MaterialPageRoute(
            builder: (_) => AddCardScreen(
                  paymentOption: routeSettings.arguments as PaymentOptions,
                ));
      case PaymentWebViewScreen.id:
        final PaymentWebViewScreenArgs paymentWebViewScreenArgs =
            routeSettings.arguments == null
                ? throw 'Need PayResponseModel'
                : (routeSettings.arguments! as PaymentWebViewScreenArgs);
        return MaterialPageRoute(
            builder: (_) => PaymentWebViewScreen(
                  paymentWebViewScreenArgs: paymentWebViewScreenArgs,
                ));
      case SavedCardsScreen.id:
        return MaterialPageRoute(builder: (_) => const SavedCardsScreen());

      default:
        return null;
    }
  }
}

class CardPaymentScreens {
  CardPaymentScreens._();

  static String addCardScreenId = AddCardScreen.id;
  static String savedCardsScreenId = SavedCardsScreen.id;
  static String paymentWebViewScreenId = PaymentWebViewScreen.id;
}
