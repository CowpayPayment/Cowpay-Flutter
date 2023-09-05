
import 'package:cowpay/cowpay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../core/core.dart';
import '../localization/localization.dart';
import '../localization/src/enum.dart';
import '../network/network.dart';
import '../routers/routers.dart';
import 'di/injection_container.dart';

class Cowpay extends StatefulWidget {
  const Cowpay({
    Key? key,
    this.localizationCode = LocalizationCode.en,
    required this.description,
    required this.merchantReferenceId,
    required this.customerMerchantProfileId,
    required this.customerEmail,
    required this.customerMobile,
    required this.activeEnvironment,
    required this.amount,
    required this.customerFirstName,
    required this.customerLastName,
    required this.merchantCode,
    required this.merchantHashCode,
    required this.merchantMobile,
    required this.isfeesOnCustomer,
    this.logoStringUrl,
    this.height,
    this.buttonColor,
    this.buttonTextColor,
    this.mainColor,
    this.buttonTextStyle,
    this.textFieldStyle,
    this.textFieldInputDecoration,
    required this.onSuccess,
    required this.onError,
    required this.onClosedByUser,
  }) : super(key: key);

  //Merchant Data
  final String merchantCode, merchantHashCode, merchantMobile;
  final String? logoStringUrl;

  //Payment Data
  final String description, merchantReferenceId;
  final num amount;
  final bool isfeesOnCustomer;
  //Customer Data
  final String customerEmail,
      customerFirstName,
      customerLastName,
      customerMobile,
      customerMerchantProfileId;

//Environment: staging or production
  final CowpayEnvironment activeEnvironment;
  //LocalizationCode: ar or en
  final LocalizationCode localizationCode;

  //onSuccess callback function
  final Function(PaymentSuccessModel paymentSuccessModel) onSuccess;

  //onError callback function
  final Function(CowpayErrorModel error) onError;

  //onClosedByUser callback function
  final Function onClosedByUser;
  //UI Customizations
  final double? height;
  final Color? buttonColor, buttonTextColor, mainColor;
  final TextStyle? buttonTextStyle, textFieldStyle;
  final InputDecoration? textFieldInputDecoration;

  @override
  State<Cowpay> createState() => _CowpayState();
}

class _CowpayState extends State<Cowpay> {
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    initDependencyInjection();
    ActiveEnvironment.environment = widget.activeEnvironment;
    Localization().setLang(widget.localizationCode);
    GlobalVariables().setGlobalVariables(
      pluginContext: context,
      amount: widget.amount,
      onSuccess: widget.onSuccess,
      onError: widget.onError,
      merchantMobile: widget.merchantMobile,
      onClosedByUser: widget.onClosedByUser,
      merchantCode: widget.merchantCode,
      merchantHashCode: widget.merchantHashCode,
      description: widget.description,
      merchantReferenceId: widget.merchantReferenceId,
      customerEmail: widget.customerEmail,
      customerFirstName: widget.customerFirstName,
      customerLastName: widget.customerLastName,
      customerMobile: widget.customerMobile,
      customerMerchantProfileId: widget.customerMerchantProfileId,
      isfeesOnCustomer: widget.isfeesOnCustomer,
      logoStringUrl: widget.logoStringUrl,
    );

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    BaseRequestDefaults.instance.setBaseUrl(ActiveEnvironment.gateWayURL);
    BaseRequestDefaults.instance
        .setAcceptedLanguage(Localization().localizationCodeString);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        builder: (BuildContext context, Widget? child) {
          return Directionality(
            textDirection: widget.localizationCode == LocalizationCode.ar
                ? TextDirection.rtl
                : TextDirection.ltr,
            child: ScreenUtilInit(
              designSize: const Size(360, 690),
              builder: (BuildContext context, Widget? child) {
                return WillPopScope(
                  onWillPop: () async {
                    var canPop =
                        GlobalVariables().navigatorKey.currentState!.canPop();
                    if (canPop) {
                      GlobalVariables()
                          .navigatorKey
                          .currentState!
                          .maybePop(true);
                    } else {
                      widget.onClosedByUser();
                    }
                    return !canPop;
                  },
                  child: Navigator(
                    key: GlobalVariables().navigatorKey,
                    onGenerateRoute: AppRouter.onGenerateRoute,
                    onPopPage: (Route<dynamic> route, dynamic result) {
                      return route.didPop(result);
                    },
                  ),
                );
              },
            ),
          );
        });
  }
}
