
import 'package:dartz/dartz.dart';

import '../../../../../domain_models/domain_models.dart';
import '../../../../../failures/failures.dart';
import '../../payment_methods_domain/payment_methods_repositories/payment_methods_repository.dart';
import '../payment_methods_datasources/payment_methods_datasource.dart';
import '../payment_methods_models/get_payment_methods_request_call/get_payment_methods_request.dart';
import '../payment_methods_models/get_token_request_call/get_token_request_model.dart';

class PaymentMethodsRepositoryImpl implements PaymentMethodsRepository {
  PaymentMethodsRemoteDataSource remoteDataSource;

  PaymentMethodsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, /*CowpayResponseModel<*/String/*>*/>> getTokenCall(
      {required GetTokenRequestModel requestModel}) async {
    try {
      final token =
          await remoteDataSource.getTokenCall(requestModel: requestModel);

      return Right(token);
    } on Exception catch (error) {
      return Left(FailureHandler(error).getExceptionFailure());
    }
  }

  @override
  Future<Either<Failure, CowpayResponseModel<List<PaymentOptions>>>>
      getPaymentMethods(
          {required GetPaymentMethodsRequestModel requestModel}) async {
    try {
      final paymentMethodsResponse =
          await remoteDataSource.getPaymentMethods(requestModel: requestModel);

      return Right(paymentMethodsResponse);
    } on Exception catch (error) {
      return Left(FailureHandler(error).getExceptionFailure());
    }
  }
}
