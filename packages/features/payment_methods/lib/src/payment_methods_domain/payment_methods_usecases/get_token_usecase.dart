import 'package:core/packages/dartz/dartz.dart';
import 'package:core/usecase/usecase.dart';
import 'package:domain_models/domain_models.dart';
import 'package:failures/failures.dart';
import 'package:payment_methods/src/payment_methods_data/payment_methods_models/get_token_request_call/get_token_request_model.dart';

import '../payment_methods_repositories/payment_methods_repository.dart';

class GetTokenUseCase
    implements
        UseCase<Future<Either<Failure, String?>>,
            GetTokenUseCaseParams> {
  final PaymentMethodsRepository repository;

  GetTokenUseCase({required this.repository});

  @override
  Future<Either<Failure, String?>> call(
      GetTokenUseCaseParams params) async {
    Either<Failure, /*CowpayResponseModel<*/String/*>*/> token =
        await repository.getTokenCall(
      requestModel: GetTokenRequestModel(
        clientId: params.clientId,
        clientSecret: params.clientSecret,
      ),
    );
    return token;
    // return token.fold((l) => Left(l), (r) => Right(r.data));
  }
}

class GetTokenUseCaseParams {
  final String clientId;
  final String clientSecret;

  GetTokenUseCaseParams({
    required this.clientId,
    required this.clientSecret,
  });
}
