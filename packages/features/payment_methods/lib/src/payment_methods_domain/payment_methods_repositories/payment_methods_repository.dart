import 'package:core/packages/dartz/dartz.dart';
import 'package:domain_models/domain_models.dart';
import 'package:failures/failures.dart';
import 'package:payment_methods/src/payment_methods_data/payment_methods_models/get_token_request_call/get_token_request_model.dart';

import '../../payment_methods_data/payment_methods_models/get_payment_methods_request_call/get_payment_methods_request.dart';

abstract class PaymentMethodsRepository {
  Future<Either<Failure, /*CowpayResponseModel<*/String/*>*/>> getTokenCall(
      {required GetTokenRequestModel requestModel});

  Future<Either<Failure, CowpayResponseModel<List<PaymentOptions>>>>
      getPaymentMethods({required GetPaymentMethodsRequestModel requestModel});
}
