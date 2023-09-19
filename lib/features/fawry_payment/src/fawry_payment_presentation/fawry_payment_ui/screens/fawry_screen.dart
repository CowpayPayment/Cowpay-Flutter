import 'package:cowpay/cowpay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../../core/core.dart';
import '../../../../../../failures/failures.dart';
import '../../../../../../ui_components/src/ui_components/back_button_view.dart';
import '../../../../../../ui_components/ui_components.dart';
import '../../../../fawry_payment.dart';
import '../../fawry_payment_blocs/fawry_bloc/fawry_bloc.dart';
import '../widgets/fawry_widget.dart';

class FawryScreen extends StatelessWidget {
  const FawryScreen({Key? key}) : super(key: key);
  static const id = '/FawryScreen';

  @override
  Widget build(BuildContext context) {
    return BackgroundView(
        appBarStartActions: const BackButtonView(),
        title: context.localization('paymentDetails'),
        contentWidget: BlocProvider<FawryBloc>(
          create: (context) => di<FawryBloc>()
            ..add(
              GetFeesEvent(),
            ),
          child: MultiBlocListener(
            listeners: [
              BlocListener<FawryBloc, FawryState>(
                listenWhen: (prev, current) => prev.failure != current.failure,
                listener: (context, state) {
                  if (state.failure != null) {
                    if (state.failure is AuthFailure) {
                      DialogView.showBottomSheet(
                          context: context,
                          builder: (builderCtx) {
                            return DialogView(
                              dialogType: DialogType.errorDialog,
                              mainButtonText: context.localization('ok'),
                              content: context
                                  .localization(state.failure!.message ?? ''),
                              onMainActionFunction: (ctx) {
                                Navigator.pop(builderCtx);
                                Navigator.of(GlobalVariables().pluginContext)
                                    .pop();
                              },
                              isDismissible: false,
                            );
                          });
                    } else if (state.failure is ServerFailure &&
                        state.feesModel != null) {
                      DialogView.showBottomSheet(
                          context: context,
                          builder: (builderCtx) {
                            return DialogView(
                              dialogType: DialogType.errorDialog,
                              mainButtonText: context.localization('close'),
                              content: context
                                  .localization(state.failure!.message ?? ''),
                              onMainActionFunction: (_) {
                                Navigator.pop(builderCtx);
                                Navigator.of(GlobalVariables().pluginContext)
                                    .pop();

                                GlobalVariables().onError(CowpayErrorModel(
                                    failureMessage: state.failure?.message,
                                    errors: state.failure?.errorsList));
                              },
                              isDismissible: false,
                            );
                          });
                    } else {
                      DialogView.showBottomSheet(
                          context: context,
                          builder: (builderCtx) {
                            return DialogView(
                              dialogType: DialogType.errorDialog,
                              mainButtonText: context.localization('retry'),
                              content: context
                                  .localization(state.failure!.message ?? ''),
                              onMainActionFunction: (_) {
                                Navigator.pop(builderCtx);
                                context.read<FawryBloc>().add(Retry());
                              },
                              isDismissible: false,
                            );
                          });
                    }
                  }
                },
              ),
              BlocListener<FawryBloc, FawryState>(
                listenWhen: (prev, current) =>
                    prev.payResponseModel != current.payResponseModel,
                listener: (context, state) {
                  if (state.payResponseModel != null) {
                    DialogView.showBottomSheet(
                        context: context,
                        builder: (builderCtx) {
                          return buildShowFawryCode(
                              state
                                  .payResponseModel!.paymentGatewayReferenceId!,
                              context);
                        });
                  }
                },
              ),
            ],
            child: BlocBuilder<FawryBloc, FawryState>(
                buildWhen: (prev, current) =>
                    prev.screenIsLoading != current.screenIsLoading,
                builder: (blocContext, state) {
                  if (state.screenIsLoading == true) {
                    return const Center(child: LoadingView());
                  }
                  return const FawryWidget();
                }),
          ),
        ));
  }

  Widget buildShowFawryCode(String fawryCode, BuildContext context) {
    return SizedBox(
      height: 0.45.sh,
      child: Column(
        children: [
          SizedBox(
            height: 0.07.sh,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(10.sp),
                decoration: BoxDecoration(
                    color: AppColors.medium.withOpacity(0.3),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: Text(
                  fawryCode,
                  style: const TextStyle(
                      color: AppColors.primary, fontWeight: FontWeight.w700),
                  textScaleFactor: 2.3,
                ),
              ),
              IconButton(
                  icon: const Icon(Icons.copy),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: fawryCode))
                        .then((value) {
                      Fluttertoast.showToast(
                          msg: context.localization('copied'),
                          toastLength: Toast.LENGTH_SHORT,
                          fontSize: 16.0);
                    });
                  }),
            ],
          ),
          SizedBox(
            height: 0.04.sh,
          ),
          SizedBox(
            width: 0.7.sw,
            child: Text(
              context.localization('fawryCodeMessage'),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: AppColors.black, fontWeight: FontWeight.w700),
              textScaleFactor: 1.5,
            ),
          ),
          SizedBox(
            height: 0.07.sh,
          ),
          ButtonView(
            textColor: AppColors.white,
            title: context.localization('close'),
            onClickFunction: (context) {
              Navigator.of(GlobalVariables().pluginContext).pop();
              GlobalVariables().onSuccess(PaymentSuccessModel(
                  paymentMethodName: PaymentOptions.fawryPay.name));
            },
            mainContext: context,
          )
        ],
      ),
    );
  }
}
