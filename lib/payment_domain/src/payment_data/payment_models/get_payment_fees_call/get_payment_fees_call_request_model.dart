import '../../../../../network/network.dart';

class GetFeesRequestModel extends RequestModel {
  GetFeesRequestModel({
    required this.merchantCode,
    required this.amount,
    required this.paymentMethodType,
    RequestProgressListener? progressListener,
  }) : super(progressListener);
  final String merchantCode;
  final num amount;
  final int paymentMethodType;

  @override
  Future<Map<String, dynamic>> toMap() async => {
        "merchantCode": merchantCode,
        "amount": amount,
        "paymentMethodType": paymentMethodType
      };

  @override
  List<Object?> get props => [
        merchantCode,
        amount,
        paymentMethodType,
      ];
}
