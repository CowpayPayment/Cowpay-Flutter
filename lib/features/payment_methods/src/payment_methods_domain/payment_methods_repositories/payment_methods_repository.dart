import '../../../../../core/packages/dartz/dartz.dart';
import '../../../../../domain_models/domain_models.dart';
import '../../../../../failures/failures.dart';
import '../../payment_methods_data/payment_methods_models/get_payment_methods_request_call/get_payment_methods_request.dart';
import '../../payment_methods_data/payment_methods_models/get_token_request_call/get_token_request_model.dart';

abstract class PaymentMethodsRepository {
  Future<Either<Failure, String>> getTokenCall(
      {required GetTokenRequestModel requestModel});

  Future<Either<Failure, CowpayResponseModel<List<PaymentOptions>>>>
      getPaymentMethods({required GetPaymentMethodsRequestModel requestModel});
}
