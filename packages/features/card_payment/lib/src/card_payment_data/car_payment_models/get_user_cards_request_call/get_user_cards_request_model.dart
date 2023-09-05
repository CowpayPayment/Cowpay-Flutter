import 'package:network/network.dart';

class GetUserCardsRequestModel extends RequestModel {
  final String merchantCode;
  final String customerProfileId;

  GetUserCardsRequestModel({
    required this.merchantCode,
    required this.customerProfileId,
    RequestProgressListener? progressListener,
  }) : super(progressListener);

  @override
  Future<Map<String, dynamic>> toMap() async => {
        "merchantCode": merchantCode,
        "customerProfileId": customerProfileId,
      };

  @override
  List<Object?> get props => [];
}
