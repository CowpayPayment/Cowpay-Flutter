class CowpayJSChannelMessage {
  final PaymentStatus paymentStatus;
  final int paymentReferenceNumber;

  CowpayJSChannelMessage(
      {required this.paymentStatus, required this.paymentReferenceNumber});

  factory CowpayJSChannelMessage.fromMap(Map<String, dynamic> map) {
    return CowpayJSChannelMessage(
        paymentReferenceNumber: map['orderId'],
        paymentStatus: PaymentStatusExtension.parse(map['status']));
  }
}

enum PaymentStatus { failed, success }

extension PaymentStatusExtension on PaymentStatus {
  static PaymentStatus parse(int? statusId) {
    switch (statusId) {
      case 5:
        return PaymentStatus.failed;
      case 2:
        return PaymentStatus.success;
      default:
        return PaymentStatus.failed;
    }
  }
}
