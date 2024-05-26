import 'package:cowpay/core/packages/screen_util/screen_util.dart';
import 'package:cowpay/features/payment_methods/src/payment_methods_presentation/payment_methods_ui/payment_options_extension.dart';
import 'package:cowpay/localization/src/localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/packages/flutter_bloc/flutter_bloc.dart';
import '../../../../../../domain_models/domain_models.dart';
import '../../../../../../failures/failures.dart';
import '../../../../../../ui_components/ui_components.dart';
import '../../../../payment_methods.dart';
import '../../payment_methods_bloc/payment_methods_bloc.dart';

class PaymentMethodsScreen extends StatelessWidget {
  static const id = '/PaymentMethodsScreen';

  const PaymentMethodsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundView(
        title: context.localization('paymentMethod'),
        contentWidget: BlocProvider<PaymentMethodsBloc>(
          create: (context) => di<PaymentMethodsBloc>()
            ..add(
              GetTokenEvent(),
            ),
          child: MultiBlocListener(
            listeners: [
              BlocListener<PaymentMethodsBloc, PaymentMethodsState>(
                listenWhen: (prev, current) => prev.failure != current.failure,
                listener: (context, state) {
                  if (state.failure != null) {
                    if (state.failure is AuthFailure) {
                      DialogView.showBottomSheet(
                          context: context,
                          isDismissible: false,
                          builder: (builderCtx) {
                            return DialogView(
                              dialogType: DialogType.errorDialog,
                              mainButtonText: context.localization('ok'),
                              content: state.failure?.message,
                              onMainActionFunction: (ctx) {
                                Navigator.pop(builderCtx);
                                Navigator.of(GlobalVariables().pluginContext)
                                    .pop();
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
                              content: state.failure?.message,
                              onMainActionFunction: (_) {
                                Navigator.pop(builderCtx);
                                context.read<PaymentMethodsBloc>().add(Retry());
                              },
                              secondButtonText: context.localization('exit'),
                              onSecondaryActionFunction: (_) {
                                Navigator.pop(builderCtx);
                                Navigator.of(GlobalVariables().pluginContext)
                                    .pop();
                              },
                              isDismissible: false,
                            );
                          });
                    }
                  }
                },
              ),
            ],
            child: BlocBuilder<PaymentMethodsBloc, PaymentMethodsState>(
                buildWhen: (prev, current) =>
                    prev.isScreenLoading != current.isScreenLoading,
                builder: (blocContext, state) {
                  if (state.isScreenLoading == true) {
                    return const Center(child: LoadingView());
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (GlobalVariables().logoStringUrl != null)
                        _buildHeader(
                            imagePath: GlobalVariables().logoStringUrl!),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: 0.05.sw,
                            left: 0.05.sw,
                            top: 0.02.sh,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.localization('selectPaymentMethod'),
                                style: TextStyles.bodyTextStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp),
                              ),
                              SizedBox(
                                height: 0.007.sh,
                              ),
                              Expanded(
                                child: BlocBuilder<PaymentMethodsBloc,
                                    PaymentMethodsState>(
                                  buildWhen: (prev, current) =>
                                      prev.paymentMethods !=
                                          current.paymentMethods ||
                                      prev.chosenMethod != current.chosenMethod,
                                  builder: (blocContext, state) {
                                    if (state.isScreenLoading == true) {
                                      return const Center(child: LoadingView());
                                    }
                                    return ListView.builder(
                                        itemCount:
                                            state.paymentMethods?.length ?? 0,
                                        padding: EdgeInsets.zero,
                                        itemBuilder: (context, index) {
                                          if ((state.paymentMethods?.length ??
                                                  0) ==
                                              0) {
                                            return _emptyWidget(
                                                text: context.localization(
                                                    'noPaymentMethodsAvailable'),
                                                context: context);
                                          }
                                          if (state.paymentMethods![index] ==
                                              PaymentOptions.unhandledMethod) {
                                            return const SizedBox();
                                          }
                                          return _buildMethodItem(
                                              paymentOption:
                                                  state.paymentMethods![index],
                                              isSelected: state
                                                      .chosenMethod?.id ==
                                                  state.paymentMethods?[index]
                                                      .id,
                                              selectMethod: (selectedMethod) {
                                                context
                                                    .read<PaymentMethodsBloc>()
                                                    .add(
                                                      MethodPickedEvent(
                                                          method:
                                                              selectedMethod),
                                                    );
                                              },
                                              context: blocContext);
                                        });
                                  },
                                ),
                              ),
                              BlocBuilder<PaymentMethodsBloc,
                                  PaymentMethodsState>(
                                buildWhen: (prev, current) =>
                                    prev.chosenMethod != current.chosenMethod,
                                builder: (blocContext, state) {
                                  return ButtonView(
                                    title: context
                                        .localization('next')
                                        .toUpperCase(),
                                    onClickFunction: (ctx) {
                                      navigateToNextScreen(
                                          state.chosenMethod, ctx);
                                    },
                                    mainContext: context,
                                  );
                                },
                              ),
                              SizedBox(
                                height: 0.1.sh,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ));
  }

  void navigateToNextScreen(PaymentOptions? method, BuildContext context) {
    if (method != null) {
      if (method.screenPath != '') {
        Navigator.of(context).pushNamed(method.screenPath, arguments: method);
      }
    }
  }

  Widget _buildMethodItem({
    required PaymentOptions paymentOption,
    bool? isSelected,
    required Function(PaymentOptions) selectMethod,
    required BuildContext context,
  }) {
    return InkWell(
      onTap: () {
        selectMethod(paymentOption);
      },
      child: Container(
        height: 0.05.sh,
        margin: EdgeInsets.symmetric(vertical: 0.004.sh),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ?? false ? AppColors.primary : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 0.03.sw,
            ),
            Image.asset(
              paymentOption.imagePath,
              width: 20.sp,
              package: 'cowpay',
            ),
            SizedBox(
              width: 0.03.sw,
            ),
            Expanded(
                child: Text(
              context.localization(paymentOption.name),
              style: TextStyles.bodyTextStyle.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp),
            )),
            Icon(
              size: 15.sp,
              isSelected ?? false
                  ? Icons.radio_button_checked
                  : Icons.radio_button_off,
              color: isSelected ?? false
                  ? AppColors.primary
                  : AppColors.primary.withOpacity(0.3),
            ),
            SizedBox(
              width: 0.03.sw,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader({required String imagePath}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.05.sw),
      child: Column(
        children: [
          SizedBox(
            height: 0.025.sh,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 0.05.sh,
                width: 0.2.sw,
                child: Image.network(
                  imagePath,
                  errorBuilder: (ctx, _, __) => const SizedBox(),
                  // fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 0.015.sh,
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: AppColors.black.withOpacity(0.2),
          )
        ],
      ),
    );
  }

  Widget _emptyWidget({String? text, required BuildContext context}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text ?? context.localization('emptyData'),
          style: TextStyles.bodyTextStyle.copyWith(color: AppColors.black),
        ),
      ],
    );
  }
}
