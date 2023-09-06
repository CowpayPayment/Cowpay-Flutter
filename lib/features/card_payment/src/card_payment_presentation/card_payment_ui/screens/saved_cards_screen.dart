import 'package:cowpay/core/packages/screen_util/screen_util.dart';
import 'package:cowpay/cowpay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/core.dart';
import '../../../../../../failures/failures.dart';
import '../../../../../../payment_domain/payment_domain.dart';
import '../../../../../../routers/routers.dart';
import '../../../../../../ui_components/ui_components.dart';
import '../../card_payment_blocs/saved_cards_bloc/saved_cards_bloc.dart';

class SavedCardsScreen extends StatelessWidget {
  static const id = '/SavedCardsScreen';

  const SavedCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundView(
        title: context.localization('saveCards'),
        contentWidget: BlocProvider<SavedCardsBloc>(
          create: (context) => di<SavedCardsBloc>()..add(GetSavedCards()),
          child: MultiBlocListener(
            listeners: [
              BlocListener<SavedCardsBloc, SavedCardsState>(
                listenWhen: (prev, current) => prev.failure != current.failure,
                listener: (context, state) {
                  if (state.failure != null) {
                    Loader.instance.hide();
                    if (state.failure is AuthFailure ||
                        state.failure is PaymentFailure) {
                      DialogView.showBottomSheet(
                          context: context,
                          isDismissible: false,
                          builder: (builderCtx) {
                            return DialogView(
                              dialogType: DialogType.errorDialog,
                              mainButtonText: context.localization('exit'),
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
                                context.read<SavedCardsBloc>().add(Retry());
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
              BlocListener<SavedCardsBloc, SavedCardsState>(
                listenWhen: (prev, current) =>
                    prev.payResponse != current.payResponse,
                listener: (context, state) {
                  if (state.payResponse != null) {
                    Loader.instance.hide();
                    Navigator.of(context).pushNamed(
                        CardPaymentScreens.paymentWebViewScreenId,
                        arguments: state.payResponse);
                  }
                },
              ),
              BlocListener<SavedCardsBloc, SavedCardsState>(
                listenWhen: (prev, current) =>
                    prev.cardsList != current.cardsList,
                listener: (context, state) {
                  if (state.cardsList != null) {
                    if (state.cardsList!.isEmpty) {
                      Navigator.of(context).pushReplacementNamed(
                          CardPaymentScreens.addCardScreenId);
                    }
                  }
                },
              ),
              BlocListener<SavedCardsBloc, SavedCardsState>(
                listenWhen: (prev, current) =>
                    prev.isScreenLoading != current.isScreenLoading,
                listener: (context, state) {
                  if (state.isScreenLoading == true) {
                    Loader.instance.show(context);
                  } else {
                    Loader.instance.hide();
                  }
                },
              ),
            ],
            child: BlocBuilder<SavedCardsBloc, SavedCardsState>(
                builder: (blocContext, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 0.02.sh,
                  ),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                context.localization('selectCard'),
                                style: TextStyles.bodyTextStyle.copyWith(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.sp),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      CardPaymentScreens.addCardScreenId);
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.add_circle_outline_rounded,
                                      color: AppColors.primary,
                                      size: 15.sp,
                                    ),
                                    SizedBox(
                                      width: 7.sp,
                                    ),
                                    Text(
                                      context.localization('addNewCard'),
                                      style: TextStyles.bodyTextStyle.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primary,
                                          fontSize: 12.sp),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 0.007.sh,
                          ),
                          Expanded(
                            child: BlocBuilder<SavedCardsBloc, SavedCardsState>(
                              buildWhen: (prev, current) =>
                                  prev.cardsList != current.cardsList ||
                                  prev.choosenCard != current.choosenCard,
                              builder: (blocContext, state) {
                                return ListView.builder(
                                    itemCount: state.cardsList?.length ?? 0,
                                    padding: EdgeInsets.only(top: 0.02.sh),
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      if ((state.cardsList?.length ?? 0) == 0) {
                                        return _emptyWidget(
                                            text: context.localization(
                                                'noPaymentMethodsAvailable'),
                                            context: context);
                                      }
                                      return _buildCardItem(
                                          card: state.cardsList![index],
                                          isSelected: state
                                                  .choosenCard?.tokenId ==
                                              state.cardsList?[index].tokenId,
                                          selectCard: (selectedMethod) {
                                            context.read<SavedCardsBloc>().add(
                                                  CardPickedEvent(
                                                    card: selectedMethod,
                                                  ),
                                                );
                                          });
                                    });
                              },
                            ),
                          ),
                          SizedBox(
                            height: 0.025.sh,
                          ),
                          BlocBuilder<SavedCardsBloc, SavedCardsState>(
                              buildWhen: (previous, current) =>
                                  previous.feesModel != current.feesModel,
                              builder: (context, state) {
                                if (state.feesModel != null) {
                                  return PaymentDetailsWidget(
                                    feesModel: state.feesModel!,
                                    amount: GlobalVariables().amount,
                                    isFeesOnCustomer:
                                        GlobalVariables().isfeesOnCustomer,
                                  );
                                } else {
                                  return const SizedBox();
                                }
                              }),
                          BlocBuilder<SavedCardsBloc, SavedCardsState>(
                            builder: (blocContext, state) {
                              return ButtonView(
                                title:
                                    context.localization('next').toUpperCase(),
                                onClickFunction: (ctx) {
                                  if (state.choosenCard != null) {
                                    showCvvPopup(blocContext);
                                  }
                                },
                                mainContext: context,
                              );
                            },
                          ),
                          SizedBox(
                            height: 0.05.sh,
                          ),
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

  void showCvvPopup(BuildContext context) {
    bool validCvv = false;
    DialogView.showBottomSheet(
        context: context,
        builder: (sheetCtx) {
          return Column(
            children: [
              SizedBox(
                width: 100.sp,
                child: TextFormField(
                  maxLength: 3,
                  keyboardType: TextInputType.number,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (txt) {
                    if (!RegExp(r"^[0-9]{3}$").hasMatch(txt ?? '')) {
                      validCvv = false;
                      return context.localization('invalidCardCvv');
                    }
                    validCvv = true;
                    return null;
                  },
                  obscureText: true,
                  onChanged: (text) {
                    context.read<SavedCardsBloc>().add(
                          CardCvvChanged(text),
                        );
                  },
                  textAlign: TextAlign.center,
                  style: TextStyles.appTextFieldStyle.copyWith(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3.sp),
                  cursorColor: AppColors.primary,
                  decoration: InputDecoration(
                    counterText: '',
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: AppColors.primary,
                      ),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primary.withOpacity(0.5)),
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ),
              SizedBox(
                height: 0.02.sh,
              ),
              Text(
                context.localization('typeCardCvvNumber'),
                style: TextStyles.bodyTextStyle.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black),
              ),
              SizedBox(
                height: 0.05.sh,
              ),
              ButtonView(
                title: context.localization('payNow').toUpperCase(),
                onClickFunction: (btnCtx) {
                  if (validCvv) {
                    Navigator.of(sheetCtx).pop();
                    context.read<SavedCardsBloc>().add(
                          PayWithCard(),
                        );
                    Loader.instance.show(context);
                  }
                },
                mainContext: context,
              )
            ],
          );
        });
  }

  Widget _buildCardItem({
    required TokenizedCardDetails card,
    bool? isSelected,
    required Function(TokenizedCardDetails) selectCard,
  }) {
    return InkWell(
      onTap: () {
        selectCard(card);
      },
      child: Container(
        height: 0.08.sh,
        margin: EdgeInsets.symmetric(vertical: 0.004.sh),
        padding: EdgeInsets.symmetric(vertical: 0.01.sh),
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
            SvgPicture.asset(
              _decideLogo(card),
              width: 30.sp,
              package: 'cowpay',
            ),
            SizedBox(
              width: 0.03.sw,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Text(card.name),
                      Text(
                        _getCardMaskedNumber(card.cardNumber),
                        style: TextStyles.bodyTextStyle.copyWith(
                            color: AppColors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp),
                      ),
                    ],
                  ),
                  Text(
                      '${card.cardExpMonth}/${card.cardExpYear?.substring((card.cardExpYear?.length ?? 0) - 2)}',
                      style: TextStyles.bodyTextStyle.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp)),
                ],
              ),
            ),
            SizedBox(
              width: 0.02.sw,
            ),
            Icon(
              size: 19.sp,
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

  String _decideLogo(TokenizedCardDetails card) {
    return card.cardNumber?.startsWith('4') == true
        ? AppAssets.visaLogoSvg
        : card.cardNumber?.startsWith('5') == true
            ? AppAssets.masterCardLogoSvg
            : '';
  }

  Widget _emptyWidget({String? text, required BuildContext context}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text ?? context.localization('emptyData'),
        ),
      ],
    );
  }

  String _getCardMaskedNumber(String? cardNumber) {
    try {
      return '**** **** **** ${cardNumber!.substring((cardNumber.length - 4))}';
    } catch (e) {
      return '';
    }
  }
}
