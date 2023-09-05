import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../failures/failures.dart';

class CardCvv extends Equatable {
  factory CardCvv(String value) => CardCvv._(_validateEmail(value));
  factory CardCvv.error(ValidationFailure failure) => CardCvv._(Left(failure));

  const CardCvv._(this.value);

  final Either<ValidationFailure, String> value;

  static Either<ValidationFailure, String> _validateEmail(String value) {
    bool isValidPassword = RegExp(r"^[0-9]{3}$").hasMatch(value);

    if (isValidPassword) {
      return Right(value);
    } else if (value.isEmpty) {
      return Left(ValidationFailure(message: 'requiredCardCvv'));
    } else {
      return Left(ValidationFailure(message: 'invalidCardCvv'));
    }
  }

  @override
  List<Object> get props => [value];
}
