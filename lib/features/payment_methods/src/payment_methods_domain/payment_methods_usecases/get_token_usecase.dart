import '../../../../../core/core.dart';
import '../../../../../core/packages/dartz/dartz.dart';
import '../../../../../failures/failures.dart';
import '../../payment_methods_data/payment_methods_models/get_token_request_call/get_token_request_model.dart';
import '../payment_methods_repositories/payment_methods_repository.dart';

class GetTokenUseCase
    implements
        UseCase<Future<Either<Failure, String?>>, GetTokenUseCaseParams> {
  final PaymentMethodsRepository repository;

  GetTokenUseCase({required this.repository});

  @override
  Future<Either<Failure, String?>> call(GetTokenUseCaseParams params) async {
    Either<Failure, String> token = await repository.getTokenCall(
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
