import 'package:domain_models/domain_models.dart';
import 'package:routers/routers.dart';
import 'package:ui_components/ui_components.dart';

extension PaymentOptionsExt on PaymentOptions {
  String get imagePath {
    switch (this) {
      case PaymentOptions.creditCard:
      case PaymentOptions.tokenizedCreditCard:
        return AppAssets.masterCardLogoPng;
      case PaymentOptions.fawryPay:
        return AppAssets.fawryLogoPng;
      case PaymentOptions.fawryB2B:
        return '';
      case PaymentOptions.meezaCard:
      case PaymentOptions.meezaPay:
        return AppAssets.meezaLogoPng;
      case PaymentOptions.bosta:
        return AppAssets.bostaLogoPng;
      case PaymentOptions.valu:
        return '';
      default:
        return '';
    }
  }

  String get screenPath {
    switch (this) {
      case PaymentOptions.creditCard:
      case PaymentOptions.tokenizedCreditCard:
        return CardPaymentScreens.savedCardsScreenId;
      case PaymentOptions.fawryPay:
        return FawryScreens.fawryScreenId;
      case PaymentOptions.fawryB2B:
        return '';
      case PaymentOptions.meezaCard:
        return '';
      case PaymentOptions.meezaPay:
        return '';
      case PaymentOptions.bosta:
        return '';
      case PaymentOptions.valu:
        return '';
      default:
        return '';
    }
  }
}
