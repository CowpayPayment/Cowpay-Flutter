import 'dart:async';
import 'dart:convert';

import 'package:cowpay/localization/src/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/packages/flutter_bloc/flutter_bloc.dart';
import '../../../../../../domain_models/domain_models.dart';
import '../../../../../../payment_domain/payment_domain.dart';
import '../../../../../../ui_components/ui_components.dart';
import '../../../card_payment_data/car_payment_models/cowpay_js_channel_message.dart';
import '../../card_payment_blocs/webview_bloc/payment_webview_bloc.dart';

class PaymentWebViewScreenArgs {
  final PayResponseModel payResponseModel;
  final PaymentOptions paymentOption;

  const PaymentWebViewScreenArgs(
      {required this.payResponseModel, required this.paymentOption});
}

class PaymentWebViewScreen extends StatelessWidget {
  final PaymentWebViewScreenArgs paymentWebViewScreenArgs;
  static const id = '/PaymentWebViewScreen';

  const PaymentWebViewScreen(
      {super.key, required this.paymentWebViewScreenArgs});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentWebViewBloc>(
      create: (context) => PaymentWebViewBloc(),
      child: PaymentWebViewWidget(
        paymentWebViewScreenArgs.payResponseModel,
        paymentWebViewScreenArgs.paymentOption,
      ),
    );
  }
}

class PaymentWebViewWidget extends StatefulWidget {
  final PayResponseModel payResponseModel;
  final PaymentOptions paymentOption;

  const PaymentWebViewWidget(this.payResponseModel, this.paymentOption,
      {Key? key})
      : super(key: key);

  @override
  State<PaymentWebViewWidget> createState() => _PaymentWebViewWidgetState();
}

class _PaymentWebViewWidgetState extends State<PaymentWebViewWidget> {
  late final WebViewController _controller;
  Completer? _completer;
  late Uint8List body = Uint8List(0);
  LoadRequestMethod loadRequestMethod = LoadRequestMethod.post;
  String? url;

  @override
  void initState() {
    if (widget.payResponseModel.statusId == PaymentStatus.redirect) {
      body = Uint8List.fromList(utf8.encode(
          'body=${jsonEncode(widget.payResponseModel.redirectParams?.body)},redirect=${widget.payResponseModel.redirectParams?.redirect}'));
    } else if (widget.payResponseModel.statusId == PaymentStatus.threeDS) {
      body = Uint8List.fromList(
        utf8.encode(
            'paReq=${jsonEncode(widget.payResponseModel.redirectParams?.paReq)},termURL=${widget.payResponseModel.redirectParams?.termUrl},md=${jsonEncode(widget.payResponseModel.redirectParams?.md)}'),
      );
    }
    if (widget.payResponseModel.redirectMethod == RedirectMethod.get ||
        widget.paymentOption == PaymentOptions.bankCard) {
      loadRequestMethod = LoadRequestMethod.get;
    }
    super.initState();
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    String? url = widget.paymentOption == PaymentOptions.bankCard
        ? "${ActiveEnvironment.redirectUrl}/customer-paymentlink/otp-redirect?token=${widget.payResponseModel.returnUrl3ds}"
        : widget.payResponseModel.redirectUrl;

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              context.read<PaymentWebViewBloc>().add(StopLoadingChanged());
            }
            debugPrint("WebView is loading (progress : $progress%)");
          },
          onPageStarted: (String url) {
            context.read<PaymentWebViewBloc>().add(StartLoadingChanged());
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) async {
            context.read<PaymentWebViewBloc>().add(StopLoadingChanged());

            debugPrint('Page finished loading: $url');
            if (true) {
              this.url = url;
              var html = widget.payResponseModel.html;

              var xx = {"html": html};

              var js = json.encode(xx);
              await _controller.runJavaScript(
                  'setTimeout(()=>{ window.postMessage($js); },3000)');
            }
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('Page resource error: code: ${error.errorCode} '
                'description: ${error.description} errorType: ${error.errorType}'
                ' isForMainFrame: ${error.isForMainFrame}');
          },
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel("JSChannel", onMessageReceived: (message) {
        context.read<PaymentWebViewBloc>().add(CompleteWebViewChanged());

        CowpayJSChannelMessage model =
            CowpayJSChannelMessage.fromMap(jsonDecode(message.message));
        if (model.paymentStatus == PaymentStatus.paid) {
          _successDialog(context, model);
        } else {
          _errorDialog(context, context.localization('paymentFailed'));
        }

        debugPrint("message:${message.toString()}");
      })
      ..loadRequest(
        // Uri.parse('https://jeeeko.github.io/js-channel/' ?? ''),
        Uri.parse(url ?? ''),
        method: loadRequestMethod,
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: widget.paymentOption == PaymentOptions.creditCard ? body : null,
      );
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PaymentWebViewBloc, PaymentWebviewState>(
          listenWhen: (previous, current) =>
              previous.isLoading != current.isLoading,
          listener: (context, state) {
            if (!state.isLoading) {
              _completer?.complete();
              _completer = Completer();
            }

            (state.isLoading)
                ? Loader.instance.show(context)
                : Loader.instance.hide();
          },
        )
      ],
      child: PopScope(
        onPopInvoked: (didPop) {
          DialogView.showBottomSheet(
              context: context,
              builder: (builderCtx) {
                return DialogView(
                  dialogType: DialogType.warningDialog,
                  mainButtonText: context.localization('exit'),
                  secondButtonText: context.localization('dismiss'),
                  content: context.localization('youAreAboutToExitPayment'),
                  onMainActionFunction: (ctx) {
                    Navigator.pop(builderCtx);
                    Navigator.of(GlobalVariables().pluginContext).pop();
                  },
                  onSecondaryActionFunction: (ctx) {
                    Navigator.pop(builderCtx);
                  },
                );
              });
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Column(
              children: [
                BlocBuilder<PaymentWebViewBloc, PaymentWebviewState>(
                    buildWhen: (previous, current) =>
                        previous.isCompleted != current.isCompleted,
                    builder: (context, state) {
                      return Expanded(
                        child: Stack(children: [
                          WebViewWidget(
                            controller: _controller,
                          ),
                          if (state.isCompleted)
                            BlurWidget(
                              child: Container(
                                color: AppColors.white,
                              ),
                            )
                        ]),
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _successDialog(
      BuildContext context, CowpayJSChannelMessage payLoadModel) {
    DialogView.showBottomSheet(
        context: context,
        isDismissible: false,
        builder: (builderCtx) {
          return DialogView(
            dialogType: DialogType.successDialog,
            mainButtonText: context.localization('exit'),
            content:
                "${context.localization('successPayment')}\n${context.localization('referenceNumber')} :${payLoadModel.paymentReferenceNumber}",
            onMainActionFunction: (ctx) {
              Navigator.pop(builderCtx);
              Navigator.of(GlobalVariables().pluginContext).pop();
              GlobalVariables().onSuccess(PaymentSuccessModel(
                  cardSuccessModel: CreditCardSuccessModel(
                      paymentReferenceId:
                          payLoadModel.paymentReferenceNumber.toString()),
                  paymentMethodName: "creditCard"));
            },
            isDismissible: false,
          );
        });
  }

  void _errorDialog(BuildContext context, String failureMessage) {
    DialogView.showBottomSheet(
        context: context,
        isDismissible: false,
        builder: (builderCtx) {
          return DialogView(
            dialogType: DialogType.errorDialog,
            mainButtonText: context.localization('exit'),
            content: context.localization('paymentFailed'),
            onMainActionFunction: (ctx) {
              Navigator.pop(builderCtx);
              Navigator.of(GlobalVariables().pluginContext).pop();
              GlobalVariables()
                  .onError(CowpayErrorModel(failureMessage: failureMessage));
            },
            isDismissible: false,
          );
        });
  }
}
