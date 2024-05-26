import 'dart:math';

import 'package:cowpay/cowpay.dart';
import 'package:flutter/material.dart';

import 'main.dart';

// ignore: must_be_immutable
class CowpayExample extends StatelessWidget {
  final Args args;

  CowpayExample({super.key, required this.args});

  num amount = 20;
  String customerEmail = "example@mail.com";
  String customerMobile = "+201123469494";
  String description = "description";
  String customerMerchantProfileId = "ExampleId122345682";
  String customerName = "Testing";
  @override
  Widget build(BuildContext context) {
    return Cowpay(
      localizationCode: LocalizationCode.en,
      amount: amount,
      customerEmail: customerEmail,
      customerMobile: customerMobile,
      customerLastName: customerName,
      customerFirstName: customerName,
      isFeesOnCustomer: args.isFeesOnMerchant,
      logoStringUrl: args.merchantIconLink,
      description: description,
      customerMerchantProfileId: customerMerchantProfileId,
      merchantReferenceId: getRandString(),
      activeEnvironment: CowpayEnvironment.production,
      merchantHashCode: args.merchantHash,
      merchantMobile: args.merchantMobileNumber,
      merchantCode: args.merchantCode,
      onSuccess: (val) {
        debugPrint(val.paymentMethodName);
      },
      onError: (val) {
        debugPrint(val.failureMessage);
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
