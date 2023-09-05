
import 'package:dartz/dartz.dart';

import '../../../../../core/core.dart';
import '../../../../../domain_models/domain_models.dart';
import '../../../../../failures/failures.dart';
import '../../payment_methods_data/payment_methods_models/get_payment_methods_request_call/get_payment_methods_request_model.dart';
import '../payment_methods_repositories/payment_methods_repository.dart';

class GetPaymentMethodsUseCase
    implements
        UseCase<Future<Either<Failure, List<PaymentOptions>?>>,
            GetPaymentMethodsUseCaseParams> {
  final PaymentMethodsRepository repository;

  GetPaymentMethodsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<PaymentOptions>?>> call(
      GetPaymentMethodsUseCaseParams params) async {
    Either<Failure, CowpayResponseModel<List<PaymentOptions>>> paymentMethods =
        await repository.getPaymentMethods(
      requestModel: GetPaymentMethodsRequestModel(
        merchantCode: params.merchantCode,
      ),
    );
    return paymentMethods.fold((l) => Left(l), (r) => Right(r.data));
  }
}

class GetPaymentMethodsUseCaseParams {
  final String merchantCode;

  GetPaymentMethodsUseCaseParams({
    required this.merchantCode,
  });
}
