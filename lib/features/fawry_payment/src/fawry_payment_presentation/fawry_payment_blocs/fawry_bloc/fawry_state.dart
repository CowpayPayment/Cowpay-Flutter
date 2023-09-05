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
      this.screenIsLoading = true});

  final num? fees;
  final FeesModel? feesModel;
  final Failure? failure;
  final bool screenIsLoading;
  final MobileNumber? mobileNumber;
  final bool submitButtonIsLoading;
  final PayResponseModel? payResponseModel;

  bool get isFormValid => (mobileNumber?.value.isRight() ?? false);

  FawryState copyWith(
      {num? fees,
      FeesModel? feesModel,
      Failure? failure,
      MobileNumber? mobileNumber,
      PayResponseModel? payResponseModel,
      bool? submitButtonIsLoading,
      bool? screenIsLoading}) {
    return FawryState(
      fees: fees ?? this.fees,
      submitButtonIsLoading:
          submitButtonIsLoading ?? this.submitButtonIsLoading,
      payResponseModel: payResponseModel ?? this.payResponseModel,
      feesModel: feesModel ?? this.feesModel,
      failure: failure ?? this.failure,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      screenIsLoading: screenIsLoading ?? this.screenIsLoading,
    );
  }

  @override
  List<Object?> get props => [
        failure,
        fees,
        feesModel,
        screenIsLoading,
        mobileNumber,
        submitButtonIsLoading,
        payResponseModel
      ];
}
