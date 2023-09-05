

import '../../../../../core/packages/dartz/dartz.dart';
import '../../../../../domain_models/domain_models.dart';
import '../../../../../failures/failures.dart';
import '../../card_payment_domain/card_payment_repositories/card_payment_repository.dart';
import '../car_payment_models/get_user_cards_request_call/get_user_cards_request.dart';
import '../card_payment_datasources/card_payment_remote_datasource.dart';

class CardPaymentRepositoryImpl implements CardPaymentRepository {
  CardPaymentRemoteDataSource remoteDataSource;
  CardPaymentRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, CowpayResponseModel<List<TokenizedCardDetails>>>> getUserCardsCall(
      {required GetUserCardsRequestModel requestModel}) async {
    try {
      final cardsList =
      await remoteDataSource.getUserCardsCall(requestModel: requestModel);
      return Right(cardsList);
    } on Exception catch (error) {
      return Left(FailureHandler(error).getExceptionFailure());
    }
  }
}
