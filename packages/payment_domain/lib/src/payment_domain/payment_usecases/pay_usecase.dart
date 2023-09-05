import 'package:core/packages/dartz/dartz.dart';
import 'package:core/usecase/usecase.dart';
import 'package:domain_models/domain_models.dart';
import 'package:failures/failures.dart';
import 'package:payment_domain/src/payment_data/payment_models/pay_call/pay_call_request.dart';
import 'package:payment_domain/src/payment_data/payment_models/tokenzied_card.dart';
import 'package:payment_domain/src/payment_domain/payment_repositories/payment_repository.dart';

import '../../payment_data/payment_models/card_data.dart';

export '../../payment_data/payment_models/card_data.dart';

class PayUseCase
    implements
        UseCase<Future<Either<Failure, PayResponseModel>>, PayUseCaseParams> {
  final PaymentRepository repository;

  PayUseCase({required this.repository});

  @override
  Future<Either<Failure, PayResponseModel>> call(
      PayUseCaseParams params) async {
    Either<Failure, CowpayResponseModel<PayResponseModel>> response =
        await repository.payCall(
      requestModel: PayRequestModel(
        paymentOptions: params.paymentOptions,
        merchantReferenceId: params.merchantReferenceId,
        customerMerchantProfileId: params.customerMerchantProfileId,
        amount: params.amount,
        signature: params.signature,
        customerMobile: params.customerMobile,
        customerEmail: params.customerEmail,
        isfeesOnCustomer: params.isfeesOnCustomer,
        description: params.description,
        customerFirstName: params.customerFirstName,
        customerLastName: params.customerLastName,
        cardData: params.cardPaymentData,
        tokenizedCard: params.tokenizedCard,
      ),
    );
    return response.fold((l) => Left(l), (r) => Right(r.data!));
  }
}

class PayUseCaseParams {
  final PaymentOptions paymentOptions;
  final CardPaymentData? cardPaymentData;
  final String merchantReferenceId;
  final String customerMerchantProfileId;
  final num amount;
  final String signature;
  final String customerMobile;
  final String customerEmail;
  final bool isfeesOnCustomer;
  final String description;
  final String customerFirstName;
  final String customerLastName;
  final TokenizedCard? tokenizedCard;

  PayUseCaseParams({
    required this.paymentOptions,
    this.cardPaymentData,
    required this.merchantReferenceId,
    required this.customerMerchantProfileId,
    required this.amount,
    required this.signature,
    required this.customerMobile,
    required this.customerEmail,
    required this.isfeesOnCustomer,
    required this.description,
    required this.customerFirstName,
    required this.customerLastName,
    this.tokenizedCard,
  });
}
