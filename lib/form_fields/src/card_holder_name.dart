

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../failures/failures.dart';

class CardHolderName extends Equatable {
  factory CardHolderName(String value) =>
      CardHolderName._(_validateEmail(value));
  factory CardHolderName.error(ValidationFailure failure) =>
      CardHolderName._(Left(failure));

  const CardHolderName._(this.value);

  final Either<ValidationFailure, String> value;

  static Either<ValidationFailure, String> _validateEmail(String value) {
    final emailValid = RegExp(r"^((?:[A-Za-z]+ ?){1,4})$").hasMatch(value);
    if (emailValid) {
      return Right(value);
    } else if (value.isEmpty) {
      return Left(ValidationFailure(message: 'requiredCardHolderName'));
    } else {
      return Left(ValidationFailure(message: 'invalidCardHolderName'));
    }
  }

  @override
  List<Object> get props => [value];
}
