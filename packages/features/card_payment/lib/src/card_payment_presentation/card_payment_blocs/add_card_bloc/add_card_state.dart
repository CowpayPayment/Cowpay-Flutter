part of 'add_card_bloc.dart';

@immutable
class AddCardState extends Equatable {
  const AddCardState({
    this.feesModel,
    this.payResponseModel,
    this.failure,
    this.screenIsLoading = true,
    this.submitButtonIsLoading = false,
    this.cardHolderName,
    this.cardNumber,
    this.cardExpiry,
    this.cardCvv,
    this.isTokenized = false,
  });

  final FeesModel? feesModel;
  final Failure? failure;
  final bool screenIsLoading;
  final bool submitButtonIsLoading;
  final CardCvv? cardCvv;
  final CardExpiry? cardExpiry;
  final CardHolderName? cardHolderName;
  final CardNumber? cardNumber;
  final bool isTokenized;
  final PayResponseModel? payResponseModel;

  bool get isFormValid =>
      (cardCvv?.value.isRight() ?? false) &&
      (cardExpiry?.value.isRight() ?? false) &&
      (cardHolderName?.value.isRight() ?? false) &&
      (cardNumber?.value.isRight() ?? false);

  AddCardState copyWith({
    FeesModel? feesModel,
    Nullable<Failure?>? failure,
    bool? screenIsLoading,
    bool? submitButtonIsLoading,
    CardCvv? cardCvv,
    CardExpiry? cardExpiry,
    CardHolderName? cardHolderName,
    CardNumber? cardNumber,
    bool? isTokenized,
    PayResponseModel? payResponseModel,
  }) {
    return AddCardState(
      feesModel: feesModel ?? this.feesModel,
      submitButtonIsLoading:
          submitButtonIsLoading ?? this.submitButtonIsLoading,
      failure: failure == null ? this.failure : failure.value,
      screenIsLoading: screenIsLoading ?? this.screenIsLoading,
      cardCvv: cardCvv ?? this.cardCvv,
      cardExpiry: cardExpiry ?? this.cardExpiry,
      cardHolderName: cardHolderName ?? this.cardHolderName,
      cardNumber: cardNumber ?? this.cardNumber,
      isTokenized: isTokenized ?? this.isTokenized,
      payResponseModel: payResponseModel ?? this.payResponseModel,
    );
  }

  @override
  List<Object?> get props => [
        failure,
        feesModel,
        screenIsLoading,
        cardCvv,
        cardExpiry,
        cardHolderName,
        cardNumber,
        isTokenized,
        submitButtonIsLoading,
        payResponseModel
      ];
}
