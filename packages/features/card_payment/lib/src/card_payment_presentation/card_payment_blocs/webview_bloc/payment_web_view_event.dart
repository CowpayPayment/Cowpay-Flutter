part of 'payment_webview_bloc.dart';

abstract class PaymentWebViewEvent {
  const PaymentWebViewEvent();
}

class StartLoadingChanged extends PaymentWebViewEvent {
  StartLoadingChanged();
}

class StopLoadingChanged extends PaymentWebViewEvent {
  StopLoadingChanged();
}

class CompleteWebViewChanged extends PaymentWebViewEvent {
  CompleteWebViewChanged();
}
