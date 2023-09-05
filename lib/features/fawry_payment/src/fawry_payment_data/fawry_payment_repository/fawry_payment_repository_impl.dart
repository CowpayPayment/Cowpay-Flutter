
import '../../fawry_payment_domain/fawry_payment_repositories/fawry_payment_repository.dart';
import '../fawry_payment_datasources/fawry_payment_remote_datasource.dart';

class FawryPaymentRepositoryImpl implements FawryPaymentRepository {
  FawryPaymentRemoteDataSource remoteDataSource;
  FawryPaymentRepositoryImpl({required this.remoteDataSource});

  // @override
  // Future<Either<Failure, LoginResponseModel>> loginCall(
  //     {required LoginRequestModel requestModel}) async {
  //   try {
  //     final userModel =
  //         await remoteDataSource.loginCall(requestModel: requestModel);
  //
  //     return Right(userModel);
  //   } on Exception catch (error) {
  //     return Left(FailureHandler(error).getExceptionFailure());
  //   }
  // }
}
