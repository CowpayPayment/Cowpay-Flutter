part of 'saved_cards_bloc.dart';

@immutable
class SavedCardsState extends Equatable {
  const SavedCardsState({
    this.failure,
    this.cardsList,
    this.choosenCard,
    this.cvvNumber,
    this.payResponse,
    this.feesModel,
    this.isScreenLoading = false,
  });

  final Failure? failure;
  final bool isScreenLoading;
  final List<TokenizedCardDetails>? cardsList;
  final TokenizedCardDetails? choosenCard;
  final String? cvvNumber;
  final PayResponseModel? payResponse;
  final FeesModel? feesModel;

  SavedCardsState copyWith(
      {Failure? failure,
      bool? isScreenLoading,
      List<TokenizedCardDetails>? cardsList,
      TokenizedCardDetails? choosenCard,
      FeesModel? feesModel,
      PayResponseModel? payResponse,
      String? cvvNumber}) {
    return SavedCardsState(
      failure: failure ?? this.failure,
      isScreenLoading: isScreenLoading ?? this.isScreenLoading,
      cardsList: cardsList ?? this.cardsList,
      choosenCard: choosenCard ?? this.choosenCard,
      cvvNumber: cvvNumber ?? this.cvvNumber,
      payResponse: payResponse ?? this.payResponse,
      feesModel: feesModel ?? this.feesModel,
    );
  }

  @override
  List<Object?> get props => [
        failure,
        isScreenLoading,
        cardsList,
        choosenCard,
        cvvNumber,
        payResponse,
        feesModel,
      ];
}
