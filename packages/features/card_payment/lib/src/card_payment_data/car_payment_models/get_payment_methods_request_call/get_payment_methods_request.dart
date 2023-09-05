import 'package:network/network.dart';

import 'get_payment_methods_request_model.dart';

export 'get_payment_methods_request_model.dart';

class GetPaymentMethodsRequest with Request, PostRequest {
  const GetPaymentMethodsRequest(this.requestModel);

  @override
  final GetPaymentMethodsRequestModel requestModel;

  @override
  String get path => "/payment/GetMerchantPaymentMethods";
}
