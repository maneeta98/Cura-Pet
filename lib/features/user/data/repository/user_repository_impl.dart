import 'package:cura_pet/app/service_locator/service_locator.dart';
import 'package:cura_pet/core/network/local/hive_service.dart';
import 'package:cura_pet/features/user/data/model/user_hive_model.dart';
import 'package:cura_pet/features/user/domain/repository/user_repository.dart';
import 'package:cura_pet/features/user/domain/entity/user_entity.dart';
import 'package:cura_pet/core/error/failure.dart';
import 'package:cura_pet/main.dart';
import 'package:dartz/dartz.dart';

/// Implements IUserRepository using HiveService as local persistence
class UserRepositoryImpl implements IUserRepository {
  final HiveService hiveService;

  UserRepositoryImpl({required this.hiveService});

  // Save a new user
  @override
  Future<Either<Failure, void>> registerUser(UserEntity user) async {
    try {
      // Convert UserEntity to Hive model
      final hiveUser = UserHiveModel(
        name: user.name,
        email: user.email,
        phone: user.phone,
        password: user.password,
      );

      await hiveService.register(hiveUser);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to register user: $e') as Failure);
    }
  }

  // Login by checking saved Hive user
  @override
  Future<Either<Failure, String>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final bool loggedIn = await hiveService.login(email, password);
      if (loggedIn) {
        return const Right("dummy_token_123"); // Token or session id
      } else {
        return Left(ServerFailure('Invalid email or password') as Failure);
      }
    } catch (e) {
      return Left(ServerFailure('Login failed: $e') as Failure);
    }
  }
}

class ServerFailure {
  ServerFailure(String s);
}
