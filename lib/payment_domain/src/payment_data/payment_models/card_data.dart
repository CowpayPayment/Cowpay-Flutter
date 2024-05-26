import '../../../../form_fields/form_fields.dart';

class CardPaymentData {
  final CardNumber cardNumber;
  final CardExpiry cardExpiry;
  final CardCvv cardCvv;
  final CardHolderName cardHolderName;
  final String returnUrl3DS;
  final bool isTokenized;
  String? cardExpiryMonth;
  String? cardExpiryYear;

  CardPaymentData({
    required this.cardNumber,
    required this.cardExpiry,
    required this.cardCvv,
    required this.cardHolderName,
    required this.returnUrl3DS,
    this.isTokenized = false,
  }) {
    List<String>? expiry =
        cardExpiry.value.fold((l) => null, (r) => r.split('/'));
    cardExpiryYear = '20${expiry?[1]}';
    cardExpiryMonth = '${expiry?[0]}';
  }
}
