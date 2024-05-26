import '../../core/packages/dartz/dartz.dart';
import '../../core/packages/equatable/equatable.dart';
import '../../failures/failures.dart';

class MobileNumber extends Equatable {
  factory MobileNumber(String value) => MobileNumber._(_validateOtpCode(value));

  factory MobileNumber.error(ValidationFailure failure) =>
      MobileNumber._(Left(failure));

  const MobileNumber._(this.value);

  final Either<ValidationFailure, String> value;

  static Either<ValidationFailure, String> _validateOtpCode(String value) {
    final mobileCardIsValid = RegExp(r"^(01[0-9]{9})$").hasMatch(value);

    if (mobileCardIsValid) {
      return Right(value);
    } else if (value.isEmpty) {
      return Left(ValidationFailure(message: 'requiredMobileNumber'));
    } else {
      return Left(ValidationFailure(message: 'invalidMobileNumber'));
    }
  }

  @override
  List<Object> get props => [value];
}
