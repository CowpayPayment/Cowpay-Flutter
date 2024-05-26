enum PaymentOptions {
  creditCard,
  tokenizedCreditCard,
  fawryPay,
  fawryB2B,
  meezaCard,
  meezaPay,
  bosta,
  valu,
  bankCard,
  unhandledMethod,
}

extension PaymentOptionsExtension on PaymentOptions {
  String get name {
    switch (this) {
      case PaymentOptions.creditCard:
      case PaymentOptions.tokenizedCreditCard:
        return 'credit_card';
      case PaymentOptions.bankCard:
        return 'bank_card';
      case PaymentOptions.fawryPay:
        return 'fawry_pay';
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
      case 12:
        return PaymentOptions.bankCard;
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
      case PaymentOptions.bankCard:
        return 'MPGSCARD';
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
      case PaymentOptions.bankCard:
        return 12;
      default:
        return 0;
    }
  }
}
