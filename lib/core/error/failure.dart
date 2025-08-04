// import 'package:equatable/equatable.dart';

// /// Base class for all failures in the application.
// ///
// /// Use this to represent different types of errors like API failures,
// /// local database failures, or unexpected errors.
// abstract class Failure extends Equatable {
//   final String message;

//   const Failure({required this.message});

//   @override
//   List<Object> get props => [message];
// }

// /// Represents a failure that occurs during local database operations.
// class LocalDatabaseFailure extends Failure {
//   const LocalDatabaseFailure({required super.message});
// }

// /// Represents a failure that occurs during API interactions.
// /// Includes an HTTP status code.
// class ApiFailure extends Failure {
//   final int statusCode;

//   const ApiFailure({required this.statusCode, required super.message});

//   @override
//   List<Object> get props => [statusCode, message];
// }

import 'package:equatable/equatable.dart';

/// Base class for all failures in the application.
///
/// Extend this class to represent different types of errors:
/// - API errors
/// - Local database errors
/// - Cache errors
/// - Network issues
/// - Unknown/unexpected errors
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
///
/// Includes an HTTP status code for debugging.
class ApiFailure extends Failure {
  final int statusCode;

  const ApiFailure({required this.statusCode, required super.message});

  @override
  List<Object> get props => [statusCode, message];
}

/// Represents a failure that occurs due to network connectivity issues.
class NetworkFailure extends Failure {
  const NetworkFailure({required super.message});
}

/// Represents a failure that occurs when cached data is unavailable or corrupted.
class CacheFailure extends Failure {
  const CacheFailure({required super.message});
}

/// Represents an unknown or unexpected failure.
class UnknownFailure extends Failure {
  const UnknownFailure({required super.message});
}
