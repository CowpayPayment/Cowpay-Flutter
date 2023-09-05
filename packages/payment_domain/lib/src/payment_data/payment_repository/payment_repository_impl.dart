import 'package:core/packages/dartz/dartz.dart';
import 'package:domain_models/domain_models.dart';
import 'package:failures/failures.dart';
import 'package:payment_domain/src/payment_data/payment_models/pay_call/pay_call_request.dart';

import '../../payment_domain/payment_repositories/payment_repository.dart';
import '../payment_datasources/payment_remote_datasource.dart';
import '../payment_models/get_payment_fees_call/get_payment_fees_call_request.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  PaymentRemoteDataSource remoteDataSource;
  PaymentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, CowpayResponseModel<FeesModel>>> getFees(
      {required GetFeesRequestModel requestModel}) async {
    try {
      final model =
          await remoteDataSource.getFeesCall(requestModel: requestModel);

      return Right(model);
    } on Exception catch (error) {
      return Left(FailureHandler(error).getExceptionFailure());
    }
  }

  @override
  Future<Either<Failure, CowpayResponseModel<PayResponseModel>>> payCall(
      {required PayRequestModel requestModel}) async {
    try {
      final model = await remoteDataSource.payCall(requestModel: requestModel);
      return Right(model);
    } on Exception catch (error) {
      return Left(FailureHandler(error).getExceptionFailure());
    }
  }
}
