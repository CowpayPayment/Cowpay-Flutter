import 'package:flutter/foundation.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/packages/dartz/dartz.dart';
import '../../../../../../core/packages/equatable/equatable.dart';
import '../../../../../../core/packages/flutter_bloc/flutter_bloc.dart';
import '../../../../../../domain_models/domain_models.dart';
import '../../../../../../failures/failures.dart';
import '../../../../../../payment_domain/payment_domain.dart';
import '../../../card_payment_domain/card_payment_usecases/get_user_cards_usecase.dart';

part 'saved_cards_event.dart';

part 'saved_cards_state.dart';

class SavedCardsBloc extends Bloc<SavedCardsEvent, SavedCardsState> {
  final GetUserCardsUseCase getUserCardsUseCase;
  final GetPaymentFeesUseCase getPaymentFeesUseCase;
  final GenerateSignatureUseCase generateSignatureUseCase;
  final PayUseCase payUseCase;
  late SavedCardsEvent? lastTriggeredEvent;

  SavedCardsBloc({
    required this.getUserCardsUseCase,
    required this.generateSignatureUseCase,
    required this.getPaymentFeesUseCase,
    required this.payUseCase,
  }) : super(const SavedCardsState()) {
    _registerEventsHandler();
  }

  void _registerEventsHandler() {
    on<SavedCardsEvent>(
      (event, emitter) async {
        if (event is GetSavedCards) {
          lastTriggeredEvent = event;
          await _getCards(emitter);
        } else if (event is PayWithCard) {
          await _payWithCard(emitter);
        } else if (event is CardPickedEvent) {
          _pickCard(emitter, event.card);
        } else if (event is CardCvvChanged) {
          _cvvChanged(emitter, event.value);
        } else if (event is GetFeesEvent) {
          lastTriggeredEvent = event;
          await getFees(
            emitter,
          );
        } else if (event is Retry) {
          add(lastTriggeredEvent!);
        }
      },
    );
  }

  Future<void> _getCards(Emitter emitter) async {
    emitter(state.copyWith(isScreenLoading: true));
    Either<Failure, List<TokenizedCardDetails>?> response =
        await getUserCardsUseCase.call(
      GetUserCardsUseCaseParams(
        merchantCode: GlobalVariables().merchantCode,
        customerProfileId: GlobalVariables().customerMerchantProfileId,
      ),
    );
    emitter(
      response.fold(
        (l) => state.copyWith(failure: l, isScreenLoading: false),
        (carsList) {
          if (carsList != null) {
            if (carsList.isNotEmpty) {
              add(GetFeesEvent());
              return state.copyWith(
                cardsList: carsList,
              );
            }
          }
          return state.copyWith(cardsList: carsList, isScreenLoading: false);
        },
      ),
    );
  }

  Future<void> getFees(Emitter emitter) async {
    emitter(state.copyWith(isScreenLoading: true));
    await _getFees(
      emitter,
      GetPaymentFeesUseCaseParams(
        merchantCode: GlobalVariables().merchantCode,
        amount: GlobalVariables().amount,
        paymentMethodType: PaymentOptions.creditCard.id,
      ),
    );
  }

  Future<void> _getFees(
      Emitter emitter, GetPaymentFeesUseCaseParams params) async {
    Either<Failure, FeesModel> response = await getPaymentFeesUseCase.call(
      params,
    );
    emitter(
      response.fold(
        (l) => state.copyWith(
          failure: l,
          isScreenLoading: false,
        ),
        (r) => state.copyWith(
          feesModel: r,
          isScreenLoading: false,
        ),
      ),
    );
  }

  Future<void> _payWithCard(Emitter emitter) async {
    String signature = generateSignatureUseCase.call(
      GenerateSignatureUseCaseParams(
        merchantCode: GlobalVariables().merchantCode,
        merchantReferenceId: GlobalVariables().merchantReferenceId,
        customerMerchantProfileId: GlobalVariables().customerMerchantProfileId,
        amount: GlobalVariables().amount,
        hashKey: GlobalVariables().merchantHashCode,
      ),
    );
    Either<Failure, PayResponseModel> response = await payUseCase.call(
      PayUseCaseParams(
        paymentOptions: PaymentOptions.tokenizedCreditCard,
        merchantReferenceId: GlobalVariables().merchantReferenceId,
        customerMerchantProfileId: GlobalVariables().customerMerchantProfileId,
        amount: GlobalVariables().amount,
        signature: signature,
        customerMobile: GlobalVariables().customerMobile,
        customerEmail: GlobalVariables().customerEmail,
        description: GlobalVariables().description,
        customerFirstName: GlobalVariables().customerFirstName,
        customerLastName: GlobalVariables().customerLastName,
        isFeesOnCustomer: GlobalVariables().isFeesOnCustomer,
        tokenizedCard: TokenizedCard(
            returnUrl3DS:
                "${ActiveEnvironment.baseUrl}:8070/customer-paymentlink/otp-redirect",
            tokenId: state.chosenCard?.tokenId ?? '',
            cardCvv: state.cvvNumber ?? ''),
      ),
    );
    emitter(response.fold(
        (l) => state.copyWith(
            failure: PaymentFailure(message: l.message),
            isScreenLoading: false),
        (r) => state.copyWith(payResponse: r, isScreenLoading: false)));
  }

  Future<void> _pickCard(Emitter emitter, TokenizedCardDetails card) async {
    emitter(state.copyWith(chosenCard: card));
  }

  Future<void> _cvvChanged(Emitter emitter, String cvv) async {
    emitter(state.copyWith(cvvNumber: cvv));
  }
}
