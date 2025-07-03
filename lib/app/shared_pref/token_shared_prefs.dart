import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/error/failure.dart';

/// Failure class specific to SharedPreferences operations
class SharedPreferencesFailure extends Failure {
  final String message;

  SharedPreferencesFailure({required this.message}) : super(message: '');

  @override
  String toString() => 'SharedPreferencesFailure: $message';
}

class TokenSharedPrefs {
  final SharedPreferences _prefs;

  TokenSharedPrefs({required SharedPreferences sharedPreferences})
    : _prefs = sharedPreferences;

  static const String _tokenKey = 'token';

  /// Save JWT token to SharedPreferences
  Future<Either<Failure, void>> saveToken(String token) async {
    try {
      final success = await _prefs.setString(_tokenKey, token);
      if (!success) {
        return Left(
          SharedPreferencesFailure(
            message: 'Failed to save token: setString returned false',
          ),
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(
        SharedPreferencesFailure(message: 'Failed to save token: $e'),
      );
    }
  }

  /// Retrieve JWT token from SharedPreferences
  Future<Either<Failure, String?>> getToken() async {
    try {
      final token = _prefs.getString(_tokenKey);
      return Right(token);
    } catch (e) {
      return Left(
        SharedPreferencesFailure(message: 'Failed to retrieve token: $e'),
      );
    }
  }

  /// Clear token from SharedPreferences (e.g., on logout)
  Future<Either<Failure, void>> clearToken() async {
    try {
      final success = await _prefs.remove(_tokenKey);
      if (!success) {
        return Left(
          SharedPreferencesFailure(
            message: 'Failed to clear token: remove returned false',
          ),
        );
      }
      return const Right(null);
    } catch (e) {
      return Left(
        SharedPreferencesFailure(message: 'Failed to clear token: $e'),
      );
    }
  }
}
