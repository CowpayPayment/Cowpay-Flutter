import '../../core/packages/get_it/get_it.dart';
import '../../features/card_payment/card_payment.dart';
import '../../features/fawry_payment/fawry_payment.dart';
import '../../features/payment_methods/payment_methods.dart';
import '../../network/network.dart';
import '../../payment_domain/payment_domain.dart';

final di = GetIt.instance;

void initDependencyInjection() {
  NetworkDI();
  PaymentMethodsDI();
  FawryPaymentDI();
  CardPaymentDI();
  PaymentDI();
}
