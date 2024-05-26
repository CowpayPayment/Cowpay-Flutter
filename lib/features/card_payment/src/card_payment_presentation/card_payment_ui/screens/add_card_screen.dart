import 'package:cowpay/core/packages/screen_util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:cowpay/cowpay.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/packages/flutter_bloc/flutter_bloc.dart';
import '../../../../../../failures/failures.dart';
import '../../../../../../payment_domain/src/payment_data/payment_models/pay_call/pay_call_response_model.dart';
import '../../../../../../payment_domain/src/payment_presentation/payment_ui/widgets/payment_details_widget.dart';
import '../../../../../../routers/routers.dart';
import '../../../../../../ui_components/src/ui_components/back_button_view.dart';
import '../../../../../../ui_components/ui_components.dart';
import '../../../../card_payment.dart';
import '../../card_payment_blocs/add_card_bloc/add_card_bloc.dart';
import '../../../../../../failures/src/error/failure.dart';

class AddCardScreen extends StatelessWidget {
  static const id = '/AddCardScreen';
  final PaymentOptions paymentOption;

  const AddCardScreen({
    super.key,
    this.paymentOption = PaymentOptions.creditCard,
  });

  @override
  Widget build(BuildContext context) {
    return BackgroundView(
        appBarStartActions: const BackButtonView(),
        title: context.localization('paymentDetails'),
        contentWidget: BlocProvider<AddCardBloc>(
          create: (context) => di<AddCardBloc>()
            ..add(
              GetFeesEvent(),
            ),
          child: MultiBlocListener(
            listeners: [
              BlocListener<AddCardBloc, AddCardState>(
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
                    } else if (state.failure is ServerFailure &&
                        state.feesModel != null) {
                      DialogView.showBottomSheet(
                          context: context,
                          isDismissible: false,
                          builder: (builderCtx) {
                            return DialogView(
                              dialogType: DialogType.errorDialog,
                              mainButtonText: context.localization('close'),
                              content: state.failure?.message,
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
                          isDismissible: false,
                          builder: (builderCtx) {
                            return DialogView(
                              dialogType: DialogType.errorDialog,
                              mainButtonText: context.localization('retry'),
                              content: state.failure?.message,
                              onMainActionFunction: (_) {
                                Navigator.pop(builderCtx);
                                context.read<AddCardBloc>().add(Retry());
                              },
                              isDismissible: false,
                            );
                          });
                    }
                  }
                },
              ),
              BlocListener<AddCardBloc, AddCardState>(
                listenWhen: (prev, current) =>
                    prev.payResponseModel != current.payResponseModel,
                listener: (context, state) {
                  if (state.payResponseModel != null) {
                    if (state.payResponseModel?.statusId ==
                            PaymentStatus.threeDS ||
                        state.payResponseModel?.statusId ==
                            PaymentStatus.redirect) {
                      Navigator.pushNamed(
                          context, CardPaymentScreens.paymentWebViewScreenId,
                          arguments: PaymentWebViewScreenArgs(
                              paymentOption: paymentOption,
                              payResponseModel: state.payResponseModel!));
                    } else if (state.payResponseModel?.statusId ==
                        PaymentStatus.paid) {
                      DialogView.showBottomSheet(
                          context: context,
                          isDismissible: false,
                          builder: (builderCtx) {
                            return DialogView(
                              dialogType: DialogType.successDialog,
                              mainButtonText: context.localization('exit'),
                              content:
                                  "${context.localization('successPayment')}\n${context.localization('referenceNumber')} :${state.payResponseModel?.cowpayReferenceId}",
                              onMainActionFunction: (ctx) {
                                Navigator.pop(builderCtx);
                                Navigator.of(GlobalVariables().pluginContext)
                                    .pop();
                                GlobalVariables().onSuccess(PaymentSuccessModel(
                                    cardSuccessModel: CreditCardSuccessModel(
                                        paymentReferenceId: state
                                                .payResponseModel
                                                ?.paymentGatewayReferenceId ??
                                            ""),
                                    paymentMethodName: "creditCard"));
                              },
                              isDismissible: false,
                            );
                          });
                    } else {
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
                                Navigator.of(GlobalVariables().pluginContext)
                                    .pop();
                                GlobalVariables().onError(CowpayErrorModel(
                                    failureMessage:
                                        context.localization('paymentFailed')));
                              },
                              isDismissible: false,
                            );
                          });
                    }
                  }
                },
              ),
            ],
            child: BlocBuilder<AddCardBloc, AddCardState>(
                buildWhen: (prev, current) =>
                    prev.screenIsLoading != current.screenIsLoading,
                builder: (blocContext, state) {
                  if (state.screenIsLoading == true) {
                    return const Center(child: LoadingView());
                  }
                  return SizedBox(
                    width: 1.sw,
                    child: Padding(
                      padding: EdgeInsetsDirectional.all(10.sp),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            context.localization("addPaymentCard"),
                            style: TextStyles.bodyTextStyle.copyWith(
                              fontSize: 12.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10.sp,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: _Form(
                                paymentOption: paymentOption,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ));
  }
}

class _Form extends StatelessWidget {
  final PaymentOptions paymentOption;

  _Form({Key? key, required this.paymentOption}) : super(key: key);
  final List<MaskTextInputFormatter> expiryFormatters = [
    MaskTextInputFormatter(mask: '##/##', type: MaskAutoCompletionType.lazy)
  ];
  final List<MaskTextInputFormatter> cardNumberFormatters = [
    MaskTextInputFormatter(
        mask: '#### #### #### ####', type: MaskAutoCompletionType.lazy)
  ];
  final List<MaskTextInputFormatter> cardNumberFormattersAr = [
    MaskTextInputFormatter(
        mask: '####-####-####-####', type: MaskAutoCompletionType.lazy)
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<AddCardBloc, AddCardState>(
            buildWhen: (previous, current) =>
                previous.cardHolderName != current.cardHolderName,
            builder: (context, state) {
              return const AppTextField().buildMainFormTextField(
                maxLength: 50,
                fieldData: FieldData(
                    label: context.localization("cardHolderName"),
                    prefixIconPath: AppAssets.holderName),
                onChange: (value) {
                  context.read<AddCardBloc>().add(CardHolderNameChanged(value));
                },
                validator: (string) => state.cardHolderName?.value
                    .fold((l) => context.localization(l.message!), (r) => null),
              );
            }),
        BlocBuilder<AddCardBloc, AddCardState>(
            buildWhen: (previous, current) =>
                previous.cardNumber != current.cardNumber,
            builder: (context, state) {
              return const AppTextField().buildMainFormTextField(
                formatters:
                    Localization().localizationCode == LocalizationCode.en
                        ? cardNumberFormatters
                        : cardNumberFormattersAr,
                fieldData: FieldData(
                    label: context.localization("cardNumber"),
                    hint: "xxxx xxxx xxxx xxxx",
                    prefixIconPath: AppAssets.cardIcon),
                textInputType: TextInputType.number,
                onChange: (value) {
                  context.read<AddCardBloc>().add(CardNumberChanged(value));
                },
                validator: (string) => state.cardNumber?.value
                    .fold((l) => context.localization(l.message!), (r) => null),
              );
            }),
        SizedBox(
          height: 80.sp,
          width: 1.sw,
          child: Row(
            children: [
              Expanded(
                child: BlocBuilder<AddCardBloc, AddCardState>(
                    buildWhen: (previous, current) =>
                        previous.cardExpiry != current.cardExpiry,
                    builder: (context, state) {
                      return const AppTextField().buildMainFormTextField(
                        maxLength: 5,
                        formatters: expiryFormatters,
                        textInputType: const TextInputType.numberWithOptions(),
                        fieldData: FieldData(
                            label: context.localization("expiryDate"),
                            hint: 'MM/YY',
                            prefixIconPath: AppAssets.expiryDateIcon),
                        onChange: (value) {
                          context
                              .read<AddCardBloc>()
                              .add(CardExpirationChanged(value));
                        },
                        validator: (string) => state.cardExpiry?.value.fold(
                            (l) => context.localization(l.message!),
                            (r) => null),
                      );
                    }),
              ),
              Expanded(
                child: BlocBuilder<AddCardBloc, AddCardState>(
                    buildWhen: (previous, current) =>
                        previous.cardCvv != current.cardCvv,
                    builder: (context, state) {
                      return const AppTextField().buildMainFormTextField(
                        maxLength: 3,
                        textInputType: TextInputType.number,
                        textInputAction: TextInputAction.done,
                        fieldData: FieldData(
                            label: context.localization("cvv"),
                            hint: 'xxx',
                            prefixIconPath: AppAssets.cvvIcon),
                        onChange: (value) {
                          context
                              .read<AddCardBloc>()
                              .add(CardCvvChanged(value));
                        },
                        validator: (string) => state.cardCvv?.value.fold(
                            (l) => context.localization(l.message!),
                            (r) => null),
                      );
                    }),
              ),
            ],
          ),
        ),
        BlocBuilder<AddCardBloc, AddCardState>(
            buildWhen: (previous, current) =>
                previous.feesModel != current.feesModel,
            builder: (context, state) {
              return PaymentDetailsWidget(
                feesModel: state.feesModel!,
                amount: GlobalVariables().amount,
                isFeesOnCustomer: GlobalVariables().isFeesOnCustomer,
              );
            }),
        SizedBox(height: 0.2.sh),
        BlocBuilder<AddCardBloc, AddCardState>(
          buildWhen: (previous, current) =>
              previous.submitButtonIsLoading != current.submitButtonIsLoading ||
              previous.cardExpiry != current.cardExpiry ||
              previous.cardCvv != current.cardCvv ||
              previous.cardNumber != current.cardNumber ||
              previous.cardHolderName != current.cardHolderName,
          builder: (context, state) {
            if (state.submitButtonIsLoading) {
              return const ButtonLoadingView();
            }
            return ButtonView(
              textColor: AppColors.white,
              title: context.localization('pay'),
              isEnabled: (state.isFormValid),
              onClickFunction: (context) {
                FocusManager.instance.primaryFocus?.unfocus();
                context
                    .read<AddCardBloc>()
                    .add(SubmitActionTapped(paymentOption: paymentOption));
              },
              mainContext: context,
              // width: 0.8.sw,
            );
          },
        ),
        SizedBox(
          height: 35.sp,
        )
      ],
    );
  }
}

class SpecialMaskTextInputFormatter extends MaskTextInputFormatter {
  static String maskA = "#### #### #### ####";
  static String maskB = "#### ### ### ### ###";

  SpecialMaskTextInputFormatter({String? initialText})
      : super(mask: maskB, initialText: initialText);

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 13) {
      if (getMask() != maskA) {
        updateMask(mask: maskA);
      }
    } else {
      if (getMask() != maskB) {
        updateMask(mask: maskB);
      }
    }
    return super.formatEditUpdate(oldValue, newValue);
  }
}
