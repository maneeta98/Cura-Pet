// import 'package:cura_pet/core/error/failure.dart';
// import 'package:cura_pet/features/user/data/data_source/remote_datasource/user_remote_data_source.dart';
// import 'package:cura_pet/features/user/domain/entity/user_entity.dart';
// import 'package:cura_pet/features/user/domain/repository/user_repository.dart';
// import 'package:dartz/dartz.dart';

// class UserRemoteRepository implements IUserRepository {
//   final UserRemoteDataSource _userRemoteDataSource;

//   UserRemoteRepository({required UserRemoteDataSource userRemoteDataSource})
//     : _userRemoteDataSource = userRemoteDataSource;

//   @override
//   Future<Either<Failure, void>> createUser(UserEntity user) async {
//     try {
//       await _userRemoteDataSource.createUser(user);
//       return const Right(null);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString(), statusCode: 500));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> deleteUser(String id) async {
//     try {
//       await _userRemoteDataSource.deleteUser(id);
//       return const Right(null);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString(), statusCode: 500));
//     }
//   }

//   @override
//   Future<Either<Failure, List<UserEntity>>> getAllUser() async {
//     try {
//       final users = await _userRemoteDataSource.getAllUser();
//       return Right(users);
//     } catch (e) {
//       return Left(ApiFailure(statusCode: 500, message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, void>> registerUser(UserEntity user) async {
//     try {
//       await _userRemoteDataSource.registerUser(user);
//       return const Right(null);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString(), statusCode: 500));
//     }
//   }

//   @override
//   Future<Either<Failure, String>> loginUser(
//     String email,
//     String password,
//   ) async {
//     try {
//       final token = await _userRemoteDataSource.loginUser(email, password);
//       return Right(token);
//     } catch (e) {
//       return Left(ApiFailure(message: e.toString(), statusCode: 500));
//     }
//   }
// }
