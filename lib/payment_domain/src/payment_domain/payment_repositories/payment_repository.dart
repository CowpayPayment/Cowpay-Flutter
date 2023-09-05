
import 'package:dartz/dartz.dart';

import '../../../../domain_models/domain_models.dart';
import '../../../../failures/failures.dart';
import '../../../payment_domain.dart';
import '../../payment_data/payment_models/get_payment_fees_call/get_payment_fees_call_request.dart';

abstract class PaymentRepository {
  Future<Either<Failure, CowpayResponseModel<FeesModel>>> getFees(
      {required GetFeesRequestModel requestModel});

  Future<Either<Failure, CowpayResponseModel<PayResponseModel>>> payCall(
      {required PayRequestModel requestModel});
}