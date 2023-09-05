import '../../../../../network/network.dart';
import 'get_payment_fees_call_request_model.dart';

export 'get_payment_fees_call_request_model.dart';
export '../fees_model.dart';

class GetFeesRequest with Request, PostRequest {
  const GetFeesRequest(this.requestModel);

  @override
  final GetFeesRequestModel requestModel;

  @override
  String get path => "/payment/CalculateFees";
}
