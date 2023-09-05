import 'package:dartz/dartz.dart';
import 'package:failures/failures.dart';

abstract class UseCase<Type, Params> {
  Type call(Params params);
}

abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> streamCall(Params params);
}
