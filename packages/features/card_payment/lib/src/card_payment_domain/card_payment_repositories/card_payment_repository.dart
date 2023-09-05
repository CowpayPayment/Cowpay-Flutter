import 'package:core/packages/dartz/dartz.dart';
import 'package:domain_models/domain_models.dart';
import 'package:failures/failures.dart';

import '../../card_payment_data/car_payment_models/get_user_cards_request_call/get_user_cards_request_model.dart';

abstract class CardPaymentRepository {
  Future<Either<Failure, CowpayResponseModel<List<TokenizedCardDetails>>>> getUserCardsCall(
      {required GetUserCardsRequestModel requestModel});
}
