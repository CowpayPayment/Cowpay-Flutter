enum PaymentOptions {
  creditCard,
  tokenizedCreditCard,
  fawryPay,
  fawryB2B,
  meezaCard,
  meezaPay,
  bosta,
  valu,
  unhandledMethod,
}

extension PaymentOptionsExtension on PaymentOptions {
  String get name {
    switch (this) {
      case PaymentOptions.creditCard:
      case PaymentOptions.tokenizedCreditCard:
        return 'Credit Card';
      case PaymentOptions.fawryPay:
        return 'Fawry Pay';
      case PaymentOptions.fawryB2B:
        return 'Fawry B2B';
      case PaymentOptions.meezaCard:
        return 'Meeza Card';
      case PaymentOptions.meezaPay:
        return 'Meeza Pay';
      case PaymentOptions.bosta:
        return 'Bosta';
      case PaymentOptions.valu:
        return 'Valu';
      default:
        return '';
    }
  }

  static PaymentOptions parse(int id) {
    switch (id) {
      case 1:
        return PaymentOptions.creditCard;
      case 2:
        return PaymentOptions.fawryPay;
      case 3:
        return PaymentOptions.fawryB2B;
      case 4:
        return PaymentOptions.meezaCard;
      case 5:
        return PaymentOptions.meezaPay;
      case 6:
        return PaymentOptions.bosta;
      case 7:
        return PaymentOptions.valu;
      default:
        return PaymentOptions.unhandledMethod;
    }
  }

  String get gatewayTargetMethod {
    switch (this) {
      case PaymentOptions.tokenizedCreditCard:
      case PaymentOptions.creditCard:
        return 'CreditCard';
      case PaymentOptions.fawryPay:
        return 'PayAtFawry';
      case PaymentOptions.bosta:
        return 'BostaCashCollection';
      case PaymentOptions.valu:
        return 'ValuPurchase';
      default:
        return "";
    }
  }

  int get id {
    switch (this) {
      case PaymentOptions.creditCard:
      case PaymentOptions.tokenizedCreditCard:
        return 1;
      case PaymentOptions.fawryPay:
        return 2;
      case PaymentOptions.fawryB2B:
        return 3;
      case PaymentOptions.meezaCard:
        return 4;
      case PaymentOptions.meezaPay:
        return 5;
      case PaymentOptions.bosta:
        return 6;
      case PaymentOptions.valu:
        return 7;
      default:
        return 0;
    }
  }
}
