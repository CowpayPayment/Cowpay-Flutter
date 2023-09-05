part of 'fawry_bloc.dart';

abstract class FawryEvent {
  const FawryEvent();
}

class GetFeesEvent extends FawryEvent {}

class PayWithCard extends FawryEvent {
  PayWithCard();
}

class Retry extends FawryEvent {
  Retry();
}

class MobileNumberChanged extends FawryEvent {
  final String value;

  MobileNumberChanged(this.value);
}

class SubmitActionTapped extends FawryEvent {
  SubmitActionTapped();
}
