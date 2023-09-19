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
      localizationCode: LocalizationCode.ar,
      amount: amount,
      customerEmail: customerEmail,
      customerMobile: customerMobile,
      customerLastName: customerName,
      customerFirstName: customerName,
      isFeesOnCustomer: isFeesOnCustomer,
      // logoStringUrl: '',
      merchantMobile: '01272009155',
      description: description,
      customerMerchantProfileId: customerMerchantProfileId,
      merchantReferenceId: getRandString(),
      activeEnvironment: CowpayEnvironment.staging,
      merchantHashCode:
          'c84dc25605d68dff91741fc937e30aeeb59eb1338b77074a84caaec0441aad21',
      merchantCode: 'b3b49e9c-878d-49bb-883f-852c5005db81',
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
