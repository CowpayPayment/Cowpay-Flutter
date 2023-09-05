import 'package:core/packages/dartz/dartz.dart';
import 'package:core/packages/equatable/equatable.dart';
import 'package:failures/failures.dart';

class CardExpiry extends Equatable {
  factory CardExpiry(String value) =>
      CardExpiry._(_validateQualification(value));
  factory CardExpiry.error(ValidationFailure failure) =>
      CardExpiry._(Left(failure));

  const CardExpiry._(this.value);

  final Either<ValidationFailure, String> value;

  static Either<ValidationFailure, String> _validateQualification(
      String value) {
    final qualificationValidation =
        RegExp(r"^(0[1-9]|10|11|12)/([0-9]{4}|[0-9]{2})$").hasMatch(value);
    if (value.isEmpty) {
      return Left(ValidationFailure(message: 'requiredCardExpiry'));
    } else if (qualificationValidation) {
      DateTime now = DateTime.now();
      DateTime thisMonth = DateTime(now.year, now.month, 1);
      String expiryYear = value.split("/")[1];
      String expiryMonth = value.split("/")[0];
      DateTime expiry =
          DateTime(int.parse("20${expiryYear}"), int.parse(expiryMonth), 1);
      if (expiry.isAfter(thisMonth) || expiry.isAtSameMomentAs(thisMonth)) {
        return Right(value);
      } else {
        return Left(ValidationFailure(message: 'invalidCardExpiryOldDate'));
      }
    }

    return Left(ValidationFailure(message: 'invalidCardExpiry'));
  }

  @override
  List<Object> get props => [value];
}
