import 'package:form_fields/form_fields.dart';

class CardPaymentData {
  final CardNumber cardNumber;
  final CardExpiry cardExpiry;
  final CardCvv cardCvv;
  final CardHolderName cardHolderName;
  final String returnUrl3DS;
  final bool isTokenized;

  CardPaymentData({
    required this.cardNumber,
    required this.cardExpiry,
    required this.cardCvv,
    required this.cardHolderName,
    required this.returnUrl3DS,
    this.isTokenized = false,
  });
}
