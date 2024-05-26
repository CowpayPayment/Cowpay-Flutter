import 'package:cowpay/core/packages/screen_util/screen_util.dart';
import 'package:cowpay/localization/src/localization.dart';
import 'package:flutter/material.dart';

import '../../../../../ui_components/ui_components.dart';
import '../../../../payment_domain.dart';

class PaymentDetailsWidget extends StatelessWidget {
  final num amount;
  final FeesModel feesModel;
  final bool isFeesOnCustomer;

  const PaymentDetailsWidget(
      {required this.feesModel,
      required this.amount,
      required this.isFeesOnCustomer,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.sp),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 0.6.sw,
                child: Text(
                    context.localization(
                      "totalPaymentAmount",
                    ),
                    style: TextStyles.bodyTextStyle.copyWith(
                        fontSize: 12.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w700)),
              ),
              Text(
                  context.localization(
                    "${((isFeesOnCustomer ? ((feesModel.fees ?? 0) + (feesModel.vatValue ?? 0)) : 0) + amount).toStringAsFixed(2)} ${context.localization("currency")}",
                  ),
                  style: TextStyles.bodyTextStyle.copyWith(
                      fontSize: 12.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w700))
            ],
          ),
          if (isFeesOnCustomer)
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.sp),
                  child: Divider(
                    height: 1,
                    thickness: 1,
                    color: AppColors.black.withOpacity(0.2),
                  ),
                ),
                _buildDetailListTile("subtotal", amount.toString(), context),
                if (feesModel.fees != null && ((feesModel.fees ?? 0) > 0))
                  _buildDetailListTile(
                      "fees", feesModel.fees.toString(), context),
                if (feesModel.vatValue != null &&
                    ((feesModel.vatValue ?? 0) > 0))
                  _buildDetailListTile(
                      "vat", feesModel.vatValue.toString(), context),
              ],
            )
          else
            SizedBox(
              height: 0.11.sh,
            ),
        ],
      ),
    );
  }

  Widget _buildDetailListTile(
      String title, String value, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 0.58.sw,
          child: Text(context.localization(title),
              style: TextStyles.bodyTextStyle.copyWith(
                fontSize: 12.sp,
                color: AppColors.black,
              )),
        ),
        Text("$value ${context.localization("currency")}",
            style: TextStyles.bodyTextStyle.copyWith(
                fontSize: 12.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w700)),
      ],
    );
  }
}
