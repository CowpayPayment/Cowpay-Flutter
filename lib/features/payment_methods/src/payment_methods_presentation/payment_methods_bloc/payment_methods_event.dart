part of 'payment_methods_bloc.dart';

abstract class PaymentMethodsEvent {
  const PaymentMethodsEvent();
}

class GetTokenEvent extends PaymentMethodsEvent {}

class GetPaymentMethods extends PaymentMethodsEvent {}

class Retry extends PaymentMethodsEvent {}

class MethodPickedEvent extends PaymentMethodsEvent {
  final PaymentOptions method;

  MethodPickedEvent({required this.method});
}

class NextActionTapped extends PaymentMethodsEvent {}
