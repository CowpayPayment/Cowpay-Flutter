import 'dart:convert';

import 'package:crypto/crypto.dart';

import '../../../../core/core.dart';

class GenerateSignatureUseCase
    implements UseCase<String, GenerateSignatureUseCaseParams> {
  GenerateSignatureUseCase();

  @override
  String call(GenerateSignatureUseCaseParams params) {
    List<String> paramList = [
      params.merchantCode,
      params.merchantReferenceId,
      params.customerMerchantProfileId,
      params.amount.toString(),
      params.hashKey
    ];
    String concatenated = paramList.join("");

    String signature = sha256.convert(utf8.encode(concatenated)).toString();

    return signature;
  }
}

class GenerateSignatureUseCaseParams {
  final String merchantCode;
  final String merchantReferenceId;
  final String customerMerchantProfileId;
  final num amount;
  final String hashKey;

  GenerateSignatureUseCaseParams({
    required this.merchantCode,
    required this.merchantReferenceId,
    required this.customerMerchantProfileId,
    required this.amount,
    required this.hashKey,
  });
}
