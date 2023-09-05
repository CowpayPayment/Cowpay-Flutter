import 'package:domain_models/domain_models.dart';
import 'package:network/network.dart';
import 'package:payment_methods/src/payment_methods_data/payment_methods_models/get_token_request_call/get_token_request.dart';
import 'package:payment_methods/src/payment_methods_data/payment_methods_models/get_token_request_call/get_token_request_model.dart';

import '../payment_methods_models/get_payment_methods_request_call/get_payment_methods_request.dart';

abstract class PaymentMethodsRemoteDataSource {
  Future</*CowpayResponseModel<*/String/*>*/> getTokenCall(
      {required GetTokenRequestModel requestModel});

  Future<CowpayResponseModel<List<PaymentOptions>>> getPaymentMethods(
      {required GetPaymentMethodsRequestModel requestModel});
}

class PaymentMethodsRemoteDataSourceImpl
    implements PaymentMethodsRemoteDataSource {
  final Network network;

  PaymentMethodsRemoteDataSourceImpl({required this.network});

  @override
  Future</*CowpayResponseModel<*/String/*>*/> getTokenCall(
      {required GetTokenRequestModel requestModel}) async {
    return await network.send(
        request: GetTokenRequest(requestModel),
        responseFromMap: (map) => /*map['data'],*/
            // CowpayResponseModel.fromJson(map, (json) {
              /*return */map);
            // }));
  }

  @override
  Future<CowpayResponseModel<List<PaymentOptions>>> getPaymentMethods(
      {required GetPaymentMethodsRequestModel requestModel}) async {
    return await network.send(
      request: GetPaymentMethodsRequest(requestModel),
      responseFromMap: (map) => CowpayResponseModel.fromJson(map, (list) {
        List<int> methodsList = list.cast<int>();
        List<PaymentOptions> paymentOptionsList =
            methodsList.map((i) => PaymentOptionsExtension.parse(i)).toList();
        return paymentOptionsList;
      }),
    );
  }
}
