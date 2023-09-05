import 'package:card_payment/src/card_payment_data/car_payment_models/get_user_cards_request_call/get_user_cards_request.dart';
import 'package:core/packages/dartz/dartz.dart';
import 'package:core/usecase/usecase.dart';
import 'package:domain_models/domain_models.dart';
import 'package:failures/failures.dart';

import '../card_payment_repositories/card_payment_repository.dart';

class GetUserCardsUseCase
    implements
        UseCase<Future<Either<Failure, List<TokenizedCardDetails>?>>,
            GetUserCardsUseCaseParams> {
  final CardPaymentRepository repository;

  GetUserCardsUseCase({required this.repository});

  @override
  Future<Either<Failure, List<TokenizedCardDetails>?>> call(
      GetUserCardsUseCaseParams params) async {
    Either<Failure, CowpayResponseModel<List<TokenizedCardDetails>?>>
        cardsResponse = await repository.getUserCardsCall(
      requestModel: GetUserCardsRequestModel(
        merchantCode: params.merchantCode,
        customerProfileId: params.customerProfileId,
      ),
    );
    return cardsResponse.fold((l) => Left(l), (r) => Right(r.data));
  }
}

class GetUserCardsUseCaseParams {
  final String merchantCode;
  final String customerProfileId;

  GetUserCardsUseCaseParams({
    required this.merchantCode,
    required this.customerProfileId,
  });
}
