part of 'saved_cards_bloc.dart';

@immutable
class SavedCardsState extends Equatable {
  const SavedCardsState({
    this.failure,
    this.cardsList,
    this.chosenCard,
    this.cvvNumber,
    this.payResponse,
    this.feesModel,
    this.isScreenLoading = false,
  });

  final Failure? failure;
  final bool isScreenLoading;
  final List<TokenizedCardDetails>? cardsList;
  final TokenizedCardDetails? chosenCard;
  final String? cvvNumber;
  final PayResponseModel? payResponse;
  final FeesModel? feesModel;

  SavedCardsState copyWith(
      {Failure? failure,
      bool? isScreenLoading,
      List<TokenizedCardDetails>? cardsList,
      TokenizedCardDetails? chosenCard,
      FeesModel? feesModel,
      PayResponseModel? payResponse,
      String? cvvNumber}) {
    return SavedCardsState(
      failure: failure ?? this.failure,
      isScreenLoading: isScreenLoading ?? this.isScreenLoading,
      cardsList: cardsList ?? this.cardsList,
      chosenCard: chosenCard ?? this.chosenCard,
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
        chosenCard,
        cvvNumber,
        payResponse,
        feesModel,
      ];
}
