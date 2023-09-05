

import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/packages/dartz/dartz.dart';
import '../../../../../../core/packages/equatable/equatable.dart';
import '../../../../../../core/packages/flutter_bloc/flutter_bloc.dart';
import '../../../../../../domain_models/domain_models.dart';
import '../../../../../../failures/failures.dart';
import '../../../../../../form_fields/form_fields.dart';
import '../../../../../../payment_domain/payment_domain.dart';

part 'add_card_event.dart';
part 'add_card_state.dart';

class AddCardBloc extends Bloc<AddCardEvent, AddCardState> {
  GetPaymentFeesUseCase getPaymentFeesUseCase;
  PayUseCase payUseCase;
  GenerateSignatureUseCase generateSignatureUseCase;
  dynamic params;

  AddCardBloc({
    required this.getPaymentFeesUseCase,
    required this.generateSignatureUseCase,
    required this.payUseCase,
  }) : super(const AddCardState()) {
    _registerEventsHandler();
  }

  void _registerEventsHandler() {
    on<AddCardEvent>(
      (event, emitter) async {
        if (event is GetFeesEvent) {
          await getFees(emitter);
        } else if (event is SubmitActionTapped) {
          await payWithCard(emitter);
        } else if (event is CardCvvChanged) {
          _cardCvvChanged(emitter, event.value);
        } else if (event is CardExpirationChanged) {
          _cardExpirationChanged(emitter, event.value);
        } else if (event is CardHolderNameChanged) {
          _cardHolderNameChanged(emitter, event.value);
        } else if (event is CardNumberChanged) {
          _cardNumberChanged(emitter, event.value);
        } else if (event is Retry) {
          await _retry(emitter);
        } else if (event is IsTokenizedChanged) {
          _isTokenizedChanged(emitter, event.value);
        }
      },
    );
  }

  Future<void> getFees(Emitter emitter) async {
    emitter(state.copyWith(screenIsLoading: true));
    params = GetPaymentFeesUseCaseParams(
        merchantCode: GlobalVariables().merchantCode,
        amount: GlobalVariables().amount,
        paymentMethodType: PaymentOptions.creditCard.id);
    await _getFees(emitter, params);
  }

  Future<void> _getFees(
      Emitter emitter, GetPaymentFeesUseCaseParams params) async {
    Either<Failure, FeesModel> response = await getPaymentFeesUseCase.call(
      params,
    );
    emitter(
      response.fold(
        (l) => state.copyWith(failure: Nullable(l), screenIsLoading: false),
        (r) => state.copyWith(feesModel: r, screenIsLoading: false),
      ),
    );
  }

  Future<void> _payWithCard(Emitter emitter, PayUseCaseParams params) async {
    Either<Failure, PayResponseModel> response = await payUseCase.call(params);
    emitter(
      response.fold(
        (l) =>
            state.copyWith(failure: Nullable(l), submitButtonIsLoading: false),
        (r) =>
            state.copyWith(payResponseModel: r, submitButtonIsLoading: false),
      ),
    );
  }

  Future<void> payWithCard(Emitter emitter) async {
    if (!state.isFormValid) return;
    emitter(state.copyWith(submitButtonIsLoading: true));

    String signature = generateSignatureUseCase.call(
      GenerateSignatureUseCaseParams(
        merchantCode: GlobalVariables().merchantCode,
        merchantReferenceId: GlobalVariables().merchantReferenceId,
        customerMerchantProfileId: GlobalVariables().customerMerchantProfileId,
        amount: GlobalVariables().amount,
        hashKey: GlobalVariables().merchantHashCode,
      ),
    );
    params = PayUseCaseParams(
      paymentOptions: PaymentOptions.creditCard,
      merchantReferenceId: GlobalVariables().merchantReferenceId,
      customerMerchantProfileId: GlobalVariables().customerMerchantProfileId,
      amount: GlobalVariables().amount,
      signature: signature,
      customerMobile: GlobalVariables().customerMobile,
      customerEmail: GlobalVariables().customerEmail,
      description: GlobalVariables().description,
      customerFirstName: GlobalVariables().customerFirstName,
      customerLastName: GlobalVariables().customerLastName,
      isfeesOnCustomer: GlobalVariables().isfeesOnCustomer,
      cardPaymentData: CardPaymentData(
        cardCvv: state.cardCvv!,
        cardExpiry: state.cardExpiry!,
        cardHolderName: state.cardHolderName!,
        cardNumber: state.cardNumber!,
        isTokenized: state.isTokenized,
        returnUrl3DS:
            "${ActiveEnvironment.baseUrl}:8070/customer-paymentlink/otp-redirect",
      ),
    );
    await _payWithCard(emitter, params);
  }

  void _cardCvvChanged(Emitter emitter, String value) {
    emitter(state.copyWith(cardCvv: CardCvv(value)));
  }

  void _cardNumberChanged(Emitter emitter, String value) {
    emitter(state.copyWith(cardNumber: CardNumber(value)));
  }

  void _cardExpirationChanged(Emitter emitter, String value) {
    emitter(state.copyWith(cardExpiry: CardExpiry(value)));
  }

  void _cardHolderNameChanged(Emitter emitter, String value) {
    emitter(state.copyWith(cardHolderName: CardHolderName(value)));
  }

  void _isTokenizedChanged(Emitter emitter, bool value) {
    emitter(state.copyWith(isTokenized: value));
  }

  Future<void> _retry(Emitter emitter) async {
    state.copyWith(failure: null);
    if (params is PayUseCaseParams) {
      await _payWithCard(emitter, params);
    } else if (params is GetPaymentFeesUseCaseParams) {
      await _getFees(emitter, params);
    }
  }
}
