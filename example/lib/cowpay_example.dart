import 'dart:math';

import 'package:cowpay/cowpay.dart';
import 'package:cowpay/localization/src/enum.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CowpayExample extends StatelessWidget {
  num amount = 2.0;
  String customerEmail = "example@mail.com";
  String customerMobile = "01234567890";
  String description = "description";
  String customerMerchantProfileId = "ExampleId2222";
  String customerName = "Testing";
  bool isFeesOnCustomer = true;

  CowpayExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Cowpay(
      localizationCode: LocalizationCode.en,
      amount: amount,
      customerEmail: customerEmail,
      customerMobile: customerMobile,
      customerLastName: customerName,
      customerFirstName: customerName,
      isFeesOnCustomer: isFeesOnCustomer,
      logoStringUrl: '',
      merchantMobile: 'merchantMobile',
      description: description,
      customerMerchantProfileId: customerMerchantProfileId,
      merchantReferenceId: getRandString(),
      activeEnvironment: CowpayEnvironment.staging,
      merchantHashCode: 'hashKey',
      merchantCode: 'merchantCode',
      onSuccess: (val) {
        debugPrint(val.paymentMethodName);
      },
      onError: (val) {
        debugPrint(val.toString());
      },
      onClosedByUser: () {
        debugPrint("closedByUser");
      },
    );
  }

  String getRandString() {
    Random random = Random();
    int randomNumber = random.nextInt(9000) + 1000;
    return randomNumber.toString();
  }
}
