import '../../../../domain_models/domain_models.dart';
import '../../../../network/network.dart';
import '../../../payment_domain.dart';

abstract class PaymentRemoteDataSource {
  Future<CowpayResponseModel<FeesModel>> getFeesCall(
      {required GetFeesRequestModel requestModel});

  Future<CowpayResponseModel<PayResponseModel>> payCall(
      {required PayRequestModel requestModel});
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  final Network network;

  PaymentRemoteDataSourceImpl({required this.network});

  @override
  Future<CowpayResponseModel<FeesModel>> getFeesCall(
      {required GetFeesRequestModel requestModel}) async {
    return await network.send(
      request: GetFeesRequest(requestModel),
      responseFromMap: (map) => CowpayResponseModel.fromJson(map, (json) {
        return FeesModel.fromMap(json);
      }),
    );
  }

  @override
  Future<CowpayResponseModel<PayResponseModel>> payCall(
      {required PayRequestModel requestModel}) async {
    return await network.send(
      request: PayRequest(requestModel),
      responseFromMap: (map) => CowpayResponseModel.fromJson(map, (map) {
        return PayResponseModel.fromJson(map);
      }),
    );
  }
}
