
import '../../../../../../network/network.dart';

class GetTokenRequestModel extends RequestModel {
  final String clientId;
  final String clientSecret;

  GetTokenRequestModel({
    required this.clientId,
    required this.clientSecret,
    RequestProgressListener? progressListener,
  }) : super(progressListener);

  @override
  Future<Map<String, dynamic>> toMap() async => {
        "clientId": "M_$clientId",
        "secret": clientSecret,
      };

  @override
  List<Object?> get props => [];
}
