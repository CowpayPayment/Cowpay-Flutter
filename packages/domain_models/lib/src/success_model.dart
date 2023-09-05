import 'package:domain_models/domain_models.dart';

class PaymentSuccessModel {
  FawrySuccessModel? fawrySuccessModel;
  CreditCardSuccessModel? cardSuccessModel;
  String paymentMethodName;

  PaymentSuccessModel(
      {this.fawrySuccessModel,
      this.cardSuccessModel,
      required this.paymentMethodName});
}
