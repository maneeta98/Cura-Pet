import 'package:equatable/equatable.dart';

/// Base class for all failures in the application.
///
/// Use this to represent different types of errors like API failures,
/// local database failures, or unexpected errors.
abstract class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

/// Represents a failure that occurs during local database operations.
class LocalDatabaseFailure extends Failure {
  const LocalDatabaseFailure({required super.message});
}

/// Represents a failure that occurs during API interactions.
/// Includes an HTTP status code.
class ApiFailure extends Failure {
  final int statusCode;

  const ApiFailure({required this.statusCode, required super.message});

  @override
  List<Object> get props => [statusCode, message];
}
