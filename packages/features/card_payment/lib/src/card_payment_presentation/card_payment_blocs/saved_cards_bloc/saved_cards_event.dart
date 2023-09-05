part of 'saved_cards_bloc.dart';

abstract class SavedCardsEvent {
  const SavedCardsEvent();
}

class GetSavedCards extends SavedCardsEvent {}

class GetFeesEvent extends SavedCardsEvent {}

class Retry extends SavedCardsEvent {}

class PayWithCard extends SavedCardsEvent {
  PayWithCard();
}

class CardPickedEvent extends SavedCardsEvent {
  final TokenizedCardDetails card;

  CardPickedEvent({required this.card});
}

class CardCvvChanged extends SavedCardsEvent {
  final String value;
  CardCvvChanged(this.value);
}

class CardNumberChanged extends SavedCardsEvent {
  final String value;
  CardNumberChanged(this.value);
}

class CardExpirationChanged extends SavedCardsEvent {
  final String value;
  CardExpirationChanged(this.value);
}

class CardHolderNameChanged extends SavedCardsEvent {
  final String value;
  CardHolderNameChanged(this.value);
}

class IsTokenizedChanged extends SavedCardsEvent {
  IsTokenizedChanged();
}
