import 'package:cura_pet/core/error/failure.dart';
import 'package:cura_pet/features/user/data/data_source/local_datasource/user_local_datasource.dart';
import 'package:cura_pet/features/user/domain/entity/user_entity.dart';
import 'package:cura_pet/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserLocalRepository implements IUserRepository {
  final UserLocalDataSource _userLocalDataSource;

  UserLocalRepository({required UserLocalDataSource userLocalDataSource})
    : _userLocalDataSource = userLocalDataSource;

  @override
  Future<Either<Failure, String>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final result = await _userLocalDataSource.loginUser(email, password);
      return Right(result); // Success: return login message or token
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to login: $e"));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(UserEntity user) async {
    try {
      await _userLocalDataSource.registerUser(user);
      return const Right(null); // Success: void return wrapped in Right
    } catch (e) {
      return Left(LocalDatabaseFailure(message: "Failed to register: $e"));
    }
  }
}
