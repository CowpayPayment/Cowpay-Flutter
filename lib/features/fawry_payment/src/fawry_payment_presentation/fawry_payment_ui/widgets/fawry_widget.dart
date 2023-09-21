import 'package:cowpay/cowpay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/core.dart';
import '../../../../../../payment_domain/payment_domain.dart';
import '../../../../../../ui_components/ui_components.dart';
import '../../fawry_payment_blocs/fawry_bloc/fawry_bloc.dart';

class FawryWidget extends StatelessWidget {
  const FawryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(
              height: 30.sp,
            ),
            Container(
              alignment: AlignmentDirectional.topStart,
              margin: EdgeInsetsDirectional.only(start: 7.sp),
              child: Text(
                context.localization('enterYourMobileNumber'),
                style: TextStyles.bodyTextStyle.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.sp),
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            BlocBuilder<FawryBloc, FawryState>(
                buildWhen: (previous, current) =>
                    previous.mobileNumber != current.mobileNumber,
                builder: (context, state) {
                  return const AppTextField().buildMainFormTextField(
                    maxLength: 11,
                    value: GlobalVariables().customerMobile,
                    fieldData: FieldData(
                        lable: context.localization("mobileNumber"),
                        hint: context.localization("mobileNumber"),
                        prefixIconPath: AppAssets.mobileIcon),
                    textInputType: TextInputType.number,
                    textInputAction: TextInputAction.done,
                    onChange: (value) {
                      context.read<FawryBloc>().add(MobileNumberChanged(value));
                    },
                    validator: (string) => state.mobileNumber?.value.fold(
                        (l) => context.localization(l.message!), (r) => null),
                  );
                }),
            SizedBox(
              height: 10.sp,
            ),
            BlocBuilder<FawryBloc, FawryState>(
                buildWhen: (previous, current) =>
                    previous.feesModel != current.feesModel,
                builder: (context, state) {
                  return PaymentDetailsWidget(
                    feesModel: state.feesModel!,
                    amount: GlobalVariables().amount,
                    isFeesOnCustomer: GlobalVariables().isfeesOnCustomer,
                  );
                }),
          ],
        ),
        Column(
          children: [
            BlocBuilder<FawryBloc, FawryState>(
              buildWhen: (previous, current) =>
                  previous.submitButtonIsLoading !=
                      current.submitButtonIsLoading ||
                  previous.mobileNumber != current.mobileNumber,
              builder: (context, state) {
                if (state.submitButtonIsLoading) {
                  return const ButtonLoadingView();
                }
                return ButtonView(
                  textColor: AppColors.white,
                  title: context.localization('proceed'),
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
            ),
          ],
        )
      ],
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
