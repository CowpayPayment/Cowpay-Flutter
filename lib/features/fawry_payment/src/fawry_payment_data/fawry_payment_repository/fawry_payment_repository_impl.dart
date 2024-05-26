import '../../fawry_payment_domain/fawry_payment_repositories/fawry_payment_repository.dart';
import '../fawry_payment_datasources/fawry_payment_remote_datasource.dart';

class FawryPaymentRepositoryImpl implements FawryPaymentRepository {
  FawryPaymentRemoteDataSource remoteDataSource;

  FawryPaymentRepositoryImpl({required this.remoteDataSource});
}
