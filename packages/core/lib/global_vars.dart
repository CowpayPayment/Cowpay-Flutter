import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';

class GlobalVariables {
  static final GlobalVariables _instance = GlobalVariables.internal();

  GlobalVariables.internal();

  factory GlobalVariables() => _instance;

  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  late BuildContext pluginContext;
  late Function(PaymentSuccessModel error) onSuccess;
  late Function(CowpayErrorModel error) onError;
  late Function onClosedByUser;
  late num amount;
  late bool isfeesOnCustomer;
  late String merchantCode, merchantHashCode;
  late String description, merchantReferenceId;
  late String merchantMobile;
  late String customerEmail,
      customerFirstName,
      customerLastName,
      customerMobile,
      customerMerchantProfileId;
  String? logoStringUrl;

  void setGlobalVariables({
    required Function onClosedByUser,
    required Function(CowpayErrorModel error) onError,
    required Function(PaymentSuccessModel success) onSuccess,
    required BuildContext pluginContext,
    required String merchantCode,
    required String merchantHashCode,
    required String description,
    required String merchantReferenceId,
    required String merchantMobile,
    required String customerEmail,
    required String customerLastName,
    required String customerFirstName,
    required String customerMobile,
    required String customerMerchantProfileId,
    required num amount,
    required bool isfeesOnCustomer,
    String? logoStringUrl,
  }) {
    this.onSuccess = onSuccess;
    this.onError = onError;
    this.onClosedByUser = onClosedByUser;
    this.pluginContext = pluginContext;
    this.merchantCode = merchantCode;
    this.merchantHashCode = merchantHashCode;
    this.description = description;
    this.merchantReferenceId = merchantReferenceId;
    this.merchantMobile = merchantMobile;
    this.customerEmail = customerEmail;
    this.customerFirstName = customerFirstName;
    this.customerLastName = customerLastName;
    this.customerMobile = customerMobile;
    this.customerMerchantProfileId = customerMerchantProfileId;
    this.amount = amount;
    this.isfeesOnCustomer = isfeesOnCustomer;
    this.logoStringUrl = logoStringUrl;
  }
}
