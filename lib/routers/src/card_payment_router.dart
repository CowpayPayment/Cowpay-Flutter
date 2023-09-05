import 'package:flutter/material.dart';

import '../../features/card_payment/card_payment.dart';
import '../../payment_domain/payment_domain.dart';

class CardPaymentRouter {
  CardPaymentRouter._();

  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AddCardScreen.id:
        return MaterialPageRoute(builder: (_) => AddCardScreen());
      case PaymentWebViewScreen.id:
        final PayResponseModel payResponseModel =
            routeSettings.arguments == null
                ? throw 'Need PayResponseModel'
                : (routeSettings.arguments! as PayResponseModel);
        return MaterialPageRoute(
            builder: (_) => PaymentWebViewScreen(
                  payResponseModel: payResponseModel,
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
