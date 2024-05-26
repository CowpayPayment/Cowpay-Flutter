import 'card_models/card_success_model.dart';
import 'fawry_models/fawry_success_model.dart';

class PaymentSuccessModel {
  FawrySuccessModel? fawrySuccessModel;
  CreditCardSuccessModel? cardSuccessModel;
  String paymentMethodName;

  PaymentSuccessModel(
      {this.fawrySuccessModel,
      this.cardSuccessModel,
      required this.paymentMethodName});
}
