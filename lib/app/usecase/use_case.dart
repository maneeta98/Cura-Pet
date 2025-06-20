import 'package:cura_pet/core/error/failure.dart';
import 'package:dartz/dartz.dart';

/// A base class for use cases that require parameters
abstract interface class UseCaseWithParams<SuccessType, Params> {
  Future<Either<Failure, SuccessType>> call(Params params);
}

/// A base class for use cases that do not require any parameters
abstract interface class UseCaseWithoutParams<SuccessType> {
  Future<Either<Failure, SuccessType>> call();
}
