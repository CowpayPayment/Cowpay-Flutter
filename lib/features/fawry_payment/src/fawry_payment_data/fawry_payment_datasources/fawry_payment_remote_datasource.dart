
import '../../../../../network/network.dart';

abstract class FawryPaymentRemoteDataSource {
  // Future<LoginResponseModel> loginCall(
  //     {required LoginRequestModel requestModel});
}

class FawryPaymentRemoteDataSourceImpl implements FawryPaymentRemoteDataSource {
  final Network network;

  FawryPaymentRemoteDataSourceImpl({required this.network});

  // @override
  // Future<LoginResponseModel> loginCall(
  //     {required LoginRequestModel requestModel}) async {
  //   return await network.send(
  //     request: LoginRequest(requestModel),
  //     responseFromMap: (map) => LoginResponseModel.fromMap(map),
  //   );
  // }
}
