import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';
import '../../../../../domain_models/domain_models.dart';
import '../../../../../failures/failures.dart';
import '../../../../../network/network.dart';
import '../../payment_methods_domain/payment_methods_usecases/get_payment_methods_usecase.dart';
import '../../payment_methods_domain/payment_methods_usecases/get_token_usecase.dart';

part 'payment_methods_event.dart';

part 'payment_methods_state.dart';

class PaymentMethodsBloc
    extends Bloc<PaymentMethodsEvent, PaymentMethodsState> {
  GetTokenUseCase getTokenUseCase;
  GetPaymentMethodsUseCase getPaymentMethodsUseCase;
  late PaymentMethodsEvent? lastTriggeredEvent;

  PaymentMethodsBloc({
    required this.getTokenUseCase,
    required this.getPaymentMethodsUseCase,
  }) : super(const PaymentMethodsState()) {
    _registerEventsHandler();
  }

  void _registerEventsHandler() {
    on<PaymentMethodsEvent>(
      (event, emitter) async {
        if (event is GetTokenEvent) {
          lastTriggeredEvent = event;
          await _getToken(emitter);
        } else if (event is MethodPickedEvent) {
          _pickMethod(emitter, event.method);
        } else if (event is GetPaymentMethods) {
          lastTriggeredEvent = event;
          await _getPaymentMethods(
            emitter,
          );
        } else if (event is Retry) {
          add(lastTriggeredEvent!);
        }
      },
    );
  }

  Future<void> _getToken(Emitter emitter) async {
    emitter(state.copyWith(isScreenLoading: true));
    Either<Failure, String?> response =
        await getTokenUseCase.call(GetTokenUseCaseParams(
      clientId: GlobalVariables().merchantCode,
      clientSecret:
          GlobalVariables().merchantCode + GlobalVariables().merchantMobile,
    ));
    emitter(
      response.fold(
        (l) => state.copyWith(
          failure: l,
          isScreenLoading: false,
        ),
        (r) {
          BaseRequestDefaults.instance.setToken(r!);
          add(GetPaymentMethods());
          return state;
        },
      ),
    );
  }

  Future<void> _getPaymentMethods(Emitter emitter) async {
    emitter(state.copyWith(isScreenLoading: true));
    Either<Failure, List<PaymentOptions>?> response =
        await getPaymentMethodsUseCase.call(
      GetPaymentMethodsUseCaseParams(
        merchantCode: GlobalVariables().merchantCode,
      ),
    );
    emitter(
      response.fold(
        (l) => state.copyWith(
          failure: l,
          isScreenLoading: false,
        ),
        (r) {
          return state.copyWith(
            isScreenLoading: false,
            paymentMethods: r,
          );
        },
      ),
    );
  }

  Future<void> _pickMethod(Emitter emitter, PaymentOptions method) async {
    emitter(state.copyWith(chosenMethod: method));
  }
}
