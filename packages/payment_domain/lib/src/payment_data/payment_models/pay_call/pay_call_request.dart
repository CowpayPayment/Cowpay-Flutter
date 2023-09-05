import 'package:network/network.dart';
import 'pay_call_request_model.dart';

export 'pay_call_request_model.dart';
export 'pay_call_response_model.dart';

class PayRequest with Request, PostRequest {
  const PayRequest(this.requestModel);

  @override
  final PayRequestModel requestModel;

  @override
  String get path => "/payment/Pay";
}
