import 'package:network/network.dart';

import 'get_user_cards_request_model.dart';
export 'get_user_cards_request_model.dart';

class GetUserCardsRequest with Request, PostRequest {
  const GetUserCardsRequest(this.requestModel);

  @override
  final GetUserCardsRequestModel requestModel;

  @override
  String get path => "/payment/GetCreditCardDetails";
}
