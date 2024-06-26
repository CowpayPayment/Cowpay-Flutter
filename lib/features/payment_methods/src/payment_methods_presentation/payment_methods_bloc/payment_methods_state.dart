part of 'payment_methods_bloc.dart';

@immutable
class PaymentMethodsState extends Equatable {
  const PaymentMethodsState({
    this.failure,
    this.chosenMethod,
    this.submitButtonIsLoading = false,
    this.isScreenLoading = false,
    this.paymentMethods,
  });

  final Failure? failure;
  final PaymentOptions? chosenMethod;
  final bool? submitButtonIsLoading;
  final bool? isScreenLoading;
  final List<PaymentOptions>? paymentMethods;

  PaymentMethodsState copyWith({
    Failure? failure,
    PaymentOptions? chosenMethod,
    bool? submitButtonIsLoading,
    bool? isScreenLoading,
    List<PaymentOptions>? paymentMethods,
  }) {
    return PaymentMethodsState(
      failure: failure,
      chosenMethod: chosenMethod ?? this.chosenMethod,
      submitButtonIsLoading:
          submitButtonIsLoading ?? this.submitButtonIsLoading,
      isScreenLoading: isScreenLoading ?? this.isScreenLoading,
      paymentMethods: paymentMethods ?? this.paymentMethods,
    );
  }

  @override
  List<Object?> get props => [
        failure,
        chosenMethod,
        submitButtonIsLoading,
        isScreenLoading,
        paymentMethods,
      ];
}
