import 'package:cowpay/core/packages/screen_util/screen_util.dart';
import 'package:cowpay/localization/src/localization.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';
import '../../../../../../core/packages/flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/packages/intl_phone_number_input/intl_phone_number_input.dart';
import '../../../../../../payment_domain/payment_domain.dart';
import '../../../../../../ui_components/ui_components.dart';
import '../../fawry_payment_blocs/fawry_bloc/fawry_bloc.dart';

class FawryWidget extends StatefulWidget {
  const FawryWidget({Key? key}) : super(key: key);

  @override
  State<FawryWidget> createState() => _FawryWidgetState();
}

class _FawryWidgetState extends State<FawryWidget> {
  PhoneNumber number = PhoneNumber(isoCode: 'EG');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          if (GlobalVariables().logoStringUrl != null)
            Column(
              children: [
                _buildHeader(imagePath: GlobalVariables().logoStringUrl!),
                SizedBox(
                  height: 0.012.sh,
                )
              ],
            ),
          BlocBuilder<FawryBloc, FawryState>(
              buildWhen: (previous, current) =>
                  previous.mobileNumber != current.mobileNumber,
              builder: (context, state) {
                return Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
                  child: Directionality(
                    textDirection: TextDirection.ltr,
                    child: InternationalPhoneNumberInput(
                      onInputChanged: (PhoneNumber number) {
                        context
                            .read<FawryBloc>()
                            .add(MobileNumberChanged(number.phoneNumber!));

                        debugPrint(number.phoneNumber);
                      },
                      errorMessage: context.localization('invalidMobileNumber'),
                      spaceBetweenSelectorAndTextField: 1,
                      inputDecoration: buildInputTextDecoration(context),
                      onInputValidated: (bool value) {
                        context.read<FawryBloc>().add(PhoneValidChanged(value));
                        debugPrint(value.toString());
                      },
                      selectorConfig: const SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                        useBottomSheetSafeArea: true,
                      ),
                      initialValue: number,
                      ignoreBlank: false,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      selectorTextStyle: const TextStyle(color: Colors.black),
                      formatInput: true,
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      inputBorder: const OutlineInputBorder(),
                      onSaved: (PhoneNumber number) {
                        debugPrint('On Saved: $number');
                      },
                    ),
                  ),
                );
              }),
          SizedBox(
            height: 30.sp,
          ),
          BlocBuilder<FawryBloc, FawryState>(
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
          BlocBuilder<FawryBloc, FawryState>(
            buildWhen: (previous, current) =>
                previous.submitButtonIsLoading !=
                    current.submitButtonIsLoading ||
                previous.mobileNumber != current.mobileNumber ||
                previous.isFormValid != current.isFormValid,
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
                  context.read<FawryBloc>().add(SubmitActionTapped());
                },
                mainContext: context,
                // width: 0.8.sw,
              );
            },
          ),
          SizedBox(
            height: 0.012.sh,
          )
        ],
      ),
    );
  }

  InputDecoration buildInputTextDecoration(BuildContext context) {
    return AppDecorations.inputTextDecoration(
      prefixIcon: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.sp),
        child: null,
      ),
      fillColor: null,
      hint: context.localization("mobileNumber"),
      // label: context.localization("mobileNumber"),
      isDense: null,
      hintTextStyle: TextStyle(
        fontFamily: FontFamily().normalFont,
        color: AppColors.primary.withOpacity(0.5),
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
      ),
      labelTextStyle: TextStyle(
        fontFamily: FontFamily().normalFont,
        color: AppColors.primary.withOpacity(0.5),
        fontSize: 12.sp,
      ),
      focusedBorderColor: AppColors.primary,
      enabledBorderColor: AppColors.primary.withOpacity(0.3),
      errorBorderColor: AppColors.errorColor,
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
            height: 0.008.sh,
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
}
