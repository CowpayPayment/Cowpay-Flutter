part of 'fawry_bloc.dart';

@immutable
class FawryState extends Equatable {
  const FawryState(
      {this.mobileNumber,
      this.fees,
      this.feesModel,
      this.payResponseModel,
      this.failure,
      this.submitButtonIsLoading = false,
      this.isFormValid = false,
      this.screenIsLoading = true});

  final num? fees;
  final FeesModel? feesModel;
  final Failure? failure;
  final bool screenIsLoading;
  final String? mobileNumber;
  final bool submitButtonIsLoading;
  final bool isFormValid;
  final PayResponseModel? payResponseModel;

  FawryState copyWith(
      {num? fees,
      FeesModel? feesModel,
      Failure? failure,
      String? mobileNumber,
      PayResponseModel? payResponseModel,
      bool? submitButtonIsLoading,
      bool? isFormValid,
      bool? screenIsLoading}) {
    return FawryState(
      fees: fees ?? this.fees,
      submitButtonIsLoading:
          submitButtonIsLoading ?? this.submitButtonIsLoading,
      payResponseModel: payResponseModel ?? this.payResponseModel,
      feesModel: feesModel ?? this.feesModel,
      failure: failure ?? this.failure,
      isFormValid: isFormValid ?? this.isFormValid,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      screenIsLoading: screenIsLoading ?? this.screenIsLoading,
    );
  }

  @override
  List<Object?> get props => [
        failure,
        fees,
        feesModel,
        isFormValid,
        screenIsLoading,
        mobileNumber,
        submitButtonIsLoading,
        payResponseModel
      ];
}
