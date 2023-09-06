# *COWPAY FLUTTER PLUGIN*

This document is a guide to the example project included in the plugin files. In addition, following the below steps will help you learn how to add and use (eKYC plugin) in your flutter application.


## REQUIREMENTS

_Minimum Flutter version 2.5.0_


## INSTALLATION

Add the following line to pubspec.yaml file.
```
dependencies:
  cowpay:
    git:
      url: https://github.com/LuminSoft/cowpay-flutter-plugin.git
      ref: v1.0.1
```


## IMPORT

```
import 'package:cowpay/cowpay.dart';
```


## USAGE

Create a widget and just return Cowpay-plugin widget in the build function as:
```
return Cowpay(
      localizationCode: LocalizationCode.en,
      amount: amount,
      customerEmail: 'customerEmail',
      customerMobile: 'customerMobile',
      customerLastName: 'customerName',
      customerFirstName: 'customerName',
      isfeesOnCustomer: true,
      logoStringUrl:'logoStringUrl',
      merchantMobile: 'merchantMobile',
      description: 'description',
      customerMerchantProfileId: 'customerMerchantProfileId',
      merchantReferenceId: 'merchantReferenceId',
      activeEnvironment: CowpayEnvironment.staging,
      merchantHashCode: 'merchantHashCode',
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
    )
```


## VALUES DESCRIPTION

|     Key       | values |
| ------------- | ------------- |
| localizationCode   | Select your language code enum value LocalizationCode.en for English, and LocalizationCode.ar if Arabic.   |
| amount   | two decimal value like "15.60", sent in case of partial capture   |
| customerEmail   | customer valid email   |
| customerMobile   | internationally formatted customer mobile   |
| customerLastName   | customer last name being charged   |
| customerFirstName   | customer first name being charged   |
| isfeesOnCustomer   | is fees on customer or merchant   |
| logoStringUrl   | merchant logo url   |
| merchantMobile   | merchant mobile   |
| description   | charge request description that reserve the payment name   |
| customerMerchantProfileId   | ID of the customer being charged on your system   |
| merchantReferenceId   | Unique alphanumeric value required as identifier for the charge request   |
| activeEnvironment   | CowpayEnvironment.staging || CowpayEnvironment.production   |
| merchantHashCode   | Hash code that is presented in your panel.   |
| merchantCode   | Your code that is presented in your panel.   |
| onSuccess   | Call back function if transaction succeeds.   |
| onError   | Call back function when an error occurres.   |
| onClosedByUser   | Call back function if customer goes back before making a transaction.   |



## DOCUMENTATION

You can  check the [documentation](https://lumin-soft.gitbook.io/cowpay/mobile-sdk).


