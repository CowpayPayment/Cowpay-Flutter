import 'package:dartz/dartz.dart';

import '../../failures/src/error/failure.dart';

abstract class UseCase<Type, Params> {
  Type call(Params params);
}

abstract class StreamUseCase<Type, Params> {
  Stream<Either<Failure, Type>> streamCall(Params params);
}
