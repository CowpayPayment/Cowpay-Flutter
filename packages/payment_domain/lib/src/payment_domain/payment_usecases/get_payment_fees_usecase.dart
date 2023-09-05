import 'package:core/packages/dartz/dartz.dart';
import 'package:core/usecase/usecase.dart';
import 'package:domain_models/domain_models.dart';
import 'package:failures/failures.dart';
import 'package:payment_domain/src/payment_data/payment_models/get_payment_fees_call/get_payment_fees_call_request.dart';
import 'package:payment_domain/src/payment_domain/payment_repositories/payment_repository.dart';

class GetPaymentFeesUseCase
    implements
        UseCase<Future<Either<Failure, FeesModel>>,
            GetPaymentFeesUseCaseParams> {
  final PaymentRepository repository;

  GetPaymentFeesUseCase({required this.repository});

  @override
  Future<Either<Failure, FeesModel>> call(
      GetPaymentFeesUseCaseParams params) async {
    Either<Failure, CowpayResponseModel<FeesModel>> response =
        await repository.getFees(
            requestModel: GetFeesRequestModel(
      merchantCode: params.merchantCode,
      amount: params.amount,
      paymentMethodType: params.paymentMethodType,
    ));
    return response.fold((l) => Left(l), (r) => Right(r.data!));
  }
}

class GetPaymentFeesUseCaseParams {
  final String merchantCode;
  final num amount;
  final int paymentMethodType;

  GetPaymentFeesUseCaseParams({
    required this.merchantCode,
    required this.amount,
    required this.paymentMethodType,
  });
}
