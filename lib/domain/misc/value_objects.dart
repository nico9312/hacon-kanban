import 'package:app/domain/misc/value_failure.dart';
import 'package:app/domain/misc/value_validators.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

///
///
///
@immutable
abstract class ValueObject<T> {
  const ValueObject();
  Either<ValueFailure, T> get value;

  /// Throws [UnexpectedValueError] containing the [ValueFailure]
  T getOrCrash() {
    // id = identity - same as writing (right) => right
    return value.fold((f) => throw Exception(f), id);
  }

  T getOrElse(T dflt) {
    return value.getOrElse(() => dflt);
  }

  Either<ValueFailure, Unit> get failureOrUnit {
    return value.fold(
      (l) => left(l),
      (r) => right(unit),
    );
  }

  bool isValid() {
    return value.isRight();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ValueObject<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Value($value)';
}

///
///
///
class DescriptionVO extends ValueObject<String> {
  @override
  final Either<ValueFailure, String> value;

  factory DescriptionVO(String? input) {
    return DescriptionVO._(
      validateStringInput(input),
    );
  }

  const DescriptionVO._(this.value);
}

///
///
///
class StatusVO extends ValueObject<String> {
  @override
  final Either<ValueFailure, String> value;

  factory StatusVO(String? input) {
    return StatusVO._(
      validateStringInput(input),
    );
  }

  const StatusVO._(this.value);
}

///
///
///
class HeadlineVO extends ValueObject<String> {
  @override
  final Either<ValueFailure, String> value;

  factory HeadlineVO(String? input) {
    return HeadlineVO._(
      validateStringInput(input),
    );
  }

  const HeadlineVO._(this.value);
}

///
///
///
class UniqueIdVO extends ValueObject<String> {
  @override
  final Either<ValueFailure, String> value;

  // We cannot let a simple String be passed in. This would allow for possible non-unique IDs.
  factory UniqueIdVO() {
    return UniqueIdVO._(
      right(const Uuid().v1()),
    );
  }

  /// Used with strings we trust are unique, such as database IDs.
  factory UniqueIdVO.fromUniqueString(String uniqueIdStr) {
    return UniqueIdVO._(
      right(uniqueIdStr),
    );
  }

  const UniqueIdVO._(this.value);
}

class PositionVO extends ValueObject<int> {
  @override
  final Either<ValueFailure, int> value;

  factory PositionVO(int? input) {
    return PositionVO._(
      validatePositiveNumber(input),
    );
  }

  const PositionVO._(this.value);
}
