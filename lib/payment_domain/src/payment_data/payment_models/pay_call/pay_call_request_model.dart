import '../../../../../domain_models/domain_models.dart';
import '../../../../../failures/failures.dart';
import '../../../../../network/network.dart';
import '../../../../payment_domain.dart';

class PayRequestModel extends RequestModel {
  PayRequestModel({
    required this.paymentOptions,
    required this.merchantReferenceId,
    required this.customerMerchantProfileId,
    required this.amount,
    required this.signature,
    required this.customerMobile,
    required this.customerEmail,
    required this.isFeesOnCustomer,
    required this.description,
    required this.customerFirstName,
    required this.customerLastName,
    this.cardData,
    this.tokenizedCard,
    RequestProgressListener? progressListener,
  }) : super(progressListener);

  final PaymentOptions paymentOptions;
  final String merchantReferenceId;
  final String customerMerchantProfileId;
  final num amount;
  final String signature;
  final String customerMobile;
  final String customerEmail;
  final bool isFeesOnCustomer;
  final String description;
  final String customerFirstName;
  final String customerLastName;
  final CardPaymentData? cardData;
  final TokenizedCard? tokenizedCard;

  @override
  Future<Map<String, dynamic>> toMap() async {
    Map<String, dynamic> map = {
      "gatewayTargetMethod": paymentOptions.gatewayTargetMethod,
      "merchantReferenceId": merchantReferenceId,
      "customerMerchantProfileId": customerMerchantProfileId,
      "amount": amount,
      "signature": signature,
      "customerMobile": customerMobile,
      "customerEmail": customerEmail,
      "isfeesOnCustomer": isFeesOnCustomer,
      "description": description,
      "customerFirstName": customerFirstName,
      "customerLastName": customerLastName,
      "customerAddress": "Big Street",
      "customerCountry": "US",
      "customerState": "CAS",
      "customerCity": "City",
      "customerZip": "123456",
      "customerIP": "123.123.123.123",
      "channelType": 1,
    };
    if ((paymentOptions == PaymentOptions.creditCard ||
            paymentOptions == PaymentOptions.bankCard) &&
        cardData != null) {
      var parts = cardData!.cardExpiry.value
          .fold((l) => throw ValidationException(l.message), (r) => r)
          .split('/');
      String cardExpMonth = parts[0];
      String cardExpYear = paymentOptions == PaymentOptions.bankCard
          ? parts[1]
          : "20${parts[1]}";

      map.addAll({
        "cardNumber": cardData!.cardNumber.value.fold(
            (l) => throw ValidationException(l.message),
            (r) => r.number.replaceAll(" ", '')),
        "cardExpMonth": cardExpMonth,
        "cardExpYear": cardExpYear,
        "cardCvv": cardData!.cardCvv.value
            .fold((l) => throw ValidationException(l.message), (r) => r),
        "cardHolderName": cardData!.cardHolderName.value
            .fold((l) => throw ValidationException(l.message), (r) => r),
        "returnUrl3DS": cardData!.returnUrl3DS,
        "isTokenized": cardData!.isTokenized,
      });
    } else if (paymentOptions == PaymentOptions.tokenizedCreditCard &&
        tokenizedCard != null) {
      map.addAll({
        "tokenId": tokenizedCard!.tokenId,
        "cardCvv": tokenizedCard!.cardCvv,
        "returnUrl3DS": tokenizedCard!.returnUrl3DS,
      });
    }
    return map;
  }

  @override
  List<Object?> get props => [
        paymentOptions,
        merchantReferenceId,
        customerMerchantProfileId,
        amount,
        signature,
        customerMobile,
        customerEmail,
        isFeesOnCustomer,
        description,
        customerFirstName,
        customerLastName,
        tokenizedCard,
        cardData
      ];
}
