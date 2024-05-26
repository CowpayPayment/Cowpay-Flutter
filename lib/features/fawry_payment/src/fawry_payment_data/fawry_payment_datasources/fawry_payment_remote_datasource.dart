import '../../../../../network/src/network.dart';

abstract class FawryPaymentRemoteDataSource {}

class FawryPaymentRemoteDataSourceImpl implements FawryPaymentRemoteDataSource {
  final Network network;

  FawryPaymentRemoteDataSourceImpl({required this.network});
}
