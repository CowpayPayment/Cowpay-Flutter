import '../../../../core/core.dart';
import '../../../../core/packages/dartz/dartz.dart';
import '../../../../domain_models/domain_models.dart';
import '../../../../failures/failures.dart';
import '../../../payment_domain.dart';
import '../payment_repositories/payment_repository.dart';

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
