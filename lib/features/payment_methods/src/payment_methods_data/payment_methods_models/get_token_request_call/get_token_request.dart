import '../../../../../../core/core.dart';
import '../../../../../../network/network.dart';
import 'get_token_request_model.dart';

class GetTokenRequest with Request, PostRequest {
  const GetTokenRequest(this.requestModel);

  @override
  final GetTokenRequestModel requestModel;

  @override
  String get path => "";

  @override
  String get url => ActiveEnvironment.tokenUrl;
}
