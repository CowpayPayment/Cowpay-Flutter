import '../../../../../payment_domain/payment_domain.dart';

class CowpayJSChannelMessage {
  final PaymentStatus paymentStatus;
  final String paymentReferenceNumber;

  CowpayJSChannelMessage(
      {required this.paymentStatus, required this.paymentReferenceNumber});

  factory CowpayJSChannelMessage.fromMap(Map<String, dynamic> map) {
    return CowpayJSChannelMessage(
        paymentReferenceNumber: map['orderNumber'],
        paymentStatus: PaymentStatusExtension.parse(map['status']));
  }
}
