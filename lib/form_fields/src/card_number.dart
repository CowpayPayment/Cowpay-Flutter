
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../failures/failures.dart';

class CardNumber extends Equatable {
  factory CardNumber(String value) => CardNumber._(_validateOtpCode(value));
  factory CardNumber.error(ValidationFailure failure) =>
      CardNumber._(Left(failure));

  const CardNumber._(this.value);

  final Either<ValidationFailure, CardNumberData> value;

  static Either<ValidationFailure, CardNumberData> _validateOtpCode(
      String value) {
    final isNumber = RegExp(r"^((?:[0-9]+ ?){4,})$").hasMatch(value);
    if (isNumber) {
      String trimedValue = value.replaceAll(" ", '');
      final masterCardIsMatched = RegExp(
              r"^(5[1-5][0-9]{14}|2(22[1-9][0-9]{12}|2[3-9][0-9]{13}|[3-6][0-9]{14}|7[0-1][0-9]{13}|720[0-9]{12}))$")
          .hasMatch(trimedValue);
      final visaCard =
          RegExp(r"^4[0-9]{12}(?:[0-9]{3})?$").hasMatch(trimedValue);
      // final visaMasterCard =
      //     RegExp(r"^(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14})$")
      //         .hasMatch(value);
      // final meeza = RegExp(r"^5078(03|09|10|11)\d{10}$").hasMatch(value);

      if (masterCardIsMatched) {
        return Right(
            CardNumberData(number: value, cardType: CardType.masterCard));
      } else if (visaCard) {
        return Right(
            CardNumberData(number: value, cardType: CardType.visaCard));
      }
      // else if (visaMasterCard) {
      //   return Right(
      //       CardNumberData(number: value, cardType: CardType.visaMasterCard));
      // }
      // else if (meeza) {
      //   return Right(CardNumberData(number: value, cardType: CardType.meeza));
      // }
      else {
        return Left(ValidationFailure(message: 'invalidCardNumber'));
      }
    } else if (value.isEmpty) {
      return Left(ValidationFailure(message: 'requiredCardNumber'));
    } else {
      return Left(ValidationFailure(message: 'invalidCardNumber'));
    }
  }

  @override
  List<Object> get props => [value];
}

enum CardType { masterCard, visaCard, visaMasterCard, meeza }

class CardNumberData {
  String number;
  CardType cardType;

  CardNumberData({required this.number, required this.cardType});
}
