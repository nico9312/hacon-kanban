import 'package:app/domain/misc/value_failure.dart';
import 'package:dartz/dartz.dart';

///
///
///
Either<ValueFailure, String> validateStringInput(String? input) {
  return input == null || input.isEmpty ? left(ValueFailure()) : right(input);
}

///
///
///
Either<ValueFailure, int> validatePositiveNumber(int? input) {
  return input == null || input < 0 ? left(ValueFailure()) : right(input);
}
