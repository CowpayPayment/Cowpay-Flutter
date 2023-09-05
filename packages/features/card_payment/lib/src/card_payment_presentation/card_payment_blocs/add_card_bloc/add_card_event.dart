part of 'add_card_bloc.dart';

abstract class AddCardEvent {
  const AddCardEvent();
}

class GetFeesEvent extends AddCardEvent {}

class SubmitActionTapped extends AddCardEvent {
  SubmitActionTapped();
}

class CardCvvChanged extends AddCardEvent {
  final String value;
  CardCvvChanged(this.value);
}

class CardNumberChanged extends AddCardEvent {
  final String value;
  CardNumberChanged(this.value);
}

class CardExpirationChanged extends AddCardEvent {
  final String value;
  CardExpirationChanged(this.value);
}

class CardHolderNameChanged extends AddCardEvent {
  final String value;
  CardHolderNameChanged(this.value);
}

class IsTokenizedChanged extends AddCardEvent {
  bool value;
  IsTokenizedChanged(this.value);
}

class Retry extends AddCardEvent {
  Retry();
}
