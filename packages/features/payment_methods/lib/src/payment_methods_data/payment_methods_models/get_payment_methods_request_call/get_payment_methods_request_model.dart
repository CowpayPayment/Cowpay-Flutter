import 'package:network/network.dart';

class GetPaymentMethodsRequestModel extends RequestModel {
  final String merchantCode;

  GetPaymentMethodsRequestModel({
    required this.merchantCode,
    RequestProgressListener? progressListener,
  }) : super(progressListener);

  @override
  Future<Map<String, dynamic>> toMap() async => {"merchantCode": merchantCode};

  @override
  List<Object?> get props => [];
}
