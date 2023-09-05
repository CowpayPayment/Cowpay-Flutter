import 'package:domain_models/domain_models.dart';
import 'package:network/network.dart';

import '../car_payment_models/get_user_cards_request_call/get_user_cards_request.dart';

abstract class CardPaymentRemoteDataSource {
  Future<CowpayResponseModel<List<TokenizedCardDetails>>> getUserCardsCall(
      {required GetUserCardsRequestModel requestModel});
}

class CardPaymentRemoteDataSourceImpl implements CardPaymentRemoteDataSource {
  final Network network;

  CardPaymentRemoteDataSourceImpl({required this.network});

  @override
  Future<CowpayResponseModel<List<TokenizedCardDetails>>> getUserCardsCall(
      {required GetUserCardsRequestModel requestModel}) async {
    return await network.send(
      request: GetUserCardsRequest(requestModel),
      responseFromMap: (map) => CowpayResponseModel.fromJson(
        map,
        (list) {
          List<Map<String, dynamic>> responseList =
              list.cast<Map<String, dynamic>>();
          return responseList.map((i) => TokenizedCardDetails.fromJson(i)).toList();
        },
      ),
    );
  }
}
