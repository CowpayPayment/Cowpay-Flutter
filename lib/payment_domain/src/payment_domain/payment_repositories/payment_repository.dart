import '../../../../core/packages/dartz/dartz.dart';
import '../../../../domain_models/domain_models.dart';
import '../../../../failures/failures.dart';
import '../../../payment_domain.dart';

abstract class PaymentRepository {
  Future<Either<Failure, CowpayResponseModel<FeesModel>>> getFees(
      {required GetFeesRequestModel requestModel});

  Future<Either<Failure, CowpayResponseModel<PayResponseModel>>> payCall(
      {required PayRequestModel requestModel});
}
