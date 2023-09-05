import 'package:core/packages/dartz/dartz.dart';
import 'package:domain_models/domain_models.dart';
import 'package:failures/failures.dart';
import 'package:payment_domain/src/payment_data/payment_models/pay_call/pay_call_request.dart';

import '../../payment_data/payment_models/get_payment_fees_call/get_payment_fees_call_request.dart';

abstract class PaymentRepository {
  Future<Either<Failure, CowpayResponseModel<FeesModel>>> getFees(
      {required GetFeesRequestModel requestModel});

  Future<Either<Failure, CowpayResponseModel<PayResponseModel>>> payCall(
      {required PayRequestModel requestModel});
}
