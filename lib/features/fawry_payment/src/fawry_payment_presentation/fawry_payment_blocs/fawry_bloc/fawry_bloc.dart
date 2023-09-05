
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/packages/equatable/equatable.dart';
import '../../../../../../domain_models/domain_models.dart';
import '../../../../../../failures/failures.dart';
import '../../../../../../form_fields/form_fields.dart';
import '../../../../../../payment_domain/payment_domain.dart';

part 'fawry_event.dart';

part 'fawry_state.dart';

class FawryBloc extends Bloc<FawryEvent, FawryState> {
  GetPaymentFeesUseCase getPaymentFeesUseCase;
  PayUseCase payUseCase;
  GenerateSignatureUseCase generateSignatureUseCase;
  dynamic params;

  FawryBloc({
    required this.getPaymentFeesUseCase,
    required this.generateSignatureUseCase,
    required this.payUseCase,
  }) : super(const FawryState()) {
    _registerEventsHandler();
  }

  void _registerEventsHandler() {
    on<FawryEvent>(
      (event, emitter) async {
        if (event is GetFeesEvent) {
          await getFees(emitter);
        } else if (event is Retry) {
          _retry(emitter);
        } else if (event is MobileNumberChanged) {
          _mobileNumberChanged(emitter, event.value);
        } else if (event is SubmitActionTapped) {
          await payWithFawry(emitter);
        }
      },
    );
  }

  void _mobileNumberChanged(Emitter emitter, String value) {
    emitter(state.copyWith(mobileNumber: MobileNumber(value)));
  }

  Future<void> getFees(Emitter emitter) async {
    emitter(state.copyWith(screenIsLoading: true));
    params = GetPaymentFeesUseCaseParams(
        merchantCode: GlobalVariables().merchantCode,
        amount: GlobalVariables().amount,
        paymentMethodType: PaymentOptions.fawryPay.id);
    await _getFees(emitter, params);
  }

  Future<void> _getFees(
      Emitter emitter, GetPaymentFeesUseCaseParams params) async {
    Either<Failure, FeesModel> response = await getPaymentFeesUseCase.call(
      params,
    );
    emitter(
      response.fold(
        (l) => state.copyWith(failure: l, screenIsLoading: false),
        (r) => state.copyWith(feesModel: r, screenIsLoading: false),
      ),
    );
  }

  void _retry(Emitter emitter) {
    if (params.runtimeType is GetPaymentFeesUseCaseParams) {
      _getFees(emitter, params);
    }
  }

  Future<void> payWithFawry(Emitter emitter) async {
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
      paymentOptions: PaymentOptions.fawryPay,
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
    );
    await _payWithFawry(emitter, params);
  }

  Future<void> _payWithFawry(Emitter emitter, PayUseCaseParams params) async {
    Either<Failure, PayResponseModel> response = await payUseCase.call(params);
    emitter(
      response.fold(
        (l) => state.copyWith(failure: l, screenIsLoading: false),
        (r) =>
            state.copyWith(payResponseModel: r, submitButtonIsLoading: false),
      ),
    );
  }
}
