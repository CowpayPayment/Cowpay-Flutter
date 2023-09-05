import 'package:core/packages/get_it/get_it.dart';
import 'package:network/network.dart';
import 'package:payment_methods/payment_methods.dart';
import 'package:fawry_payment/fawry_payment.dart';
import 'package:card_payment/card_payment.dart';
import 'package:payment_domain/payment_domain.dart';

final di = GetIt.instance;

void initDependencyInjection() {
  NetworkDI();
  PaymentMethodsDI();
  FawryPaymentDI();
  CardPaymentDI();
  PaymentDI();
}
