// // import 'package:cura_pet/core/network/remote/api_service.dart';
// // import 'package:cura_pet/app/constant/remote/api_endpoints.dart';
// // import 'package:cura_pet/features/user/data/model/user_api_model.dart';
// // import 'package:cura_pet/features/user/domain/entity/user_entity.dart';

// // class UserRemoteDataSource {
// //   final ApiService _apiService;

// //   UserRemoteDataSource({required ApiService apiService})
// //     : _apiService = apiService;

// //   Future<void> registerUser(UserEntity user) async {
// //     final model = UserApiModel.fromEntity(user);
// //     await _apiService.dio.post(ApiEndpoints.register, data: model.toJson());
// //   }

// //   Future<String> loginUser(String mobile, String password) async {
// //     final response = await _apiService.dio.post(
// //       ApiEndpoints.login,
// //       data: {'mobile': mobile, 'password': password},
// //     );

// //     return response.data['token'] as String;
// //   }
// // }

// import 'package:cura_pet/app/service_locator/service_locator.dart';
// import 'package:cura_pet/features/user/data/data_source/remote_datasource/user_remote_data_source.dart';
// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';

// import 'package:cura_pet/core/error/failure.dart';
// import 'package:cura_pet/app/shared_pref/token_shared_prefs.dart';
// import 'package:cura_pet/features/user/domain/entity/user_entity.dart';
// import 'package:cura_pet/features/user/domain/repository/user_repository.dart';

// /// Implementation of IUserRepository that interacts with remote APIs
// /// via [UserRemoteDataSource].
// class UserRemoteRepository implements IUserRepository {
//   final UserRemoteDataSource remoteDataSource;
//   final TokenSharedPrefs? tokenSharedPrefs; // optional, for saving token

//   UserRemoteRepository({
//     required this.remoteDataSource,
//     this.tokenSharedPrefs,
//     required UserRemoteDataSource userRemoteDataSource,
//   });

//   @override
//   Future<Either<Failure, void>> registerUser(UserEntity user) async {
//     try {
//       await remoteDataSource.registerUser(user);
//       return const Right(null);
//     } on DioException catch (e) {
//       // Handle Dio-specific errors
//       return Left(
//         ApiFailure(
//           statusCode: e.response?.statusCode ?? 500,
//           message:
//               e.response?.data.toString() ?? e.message ?? 'Registration failed',
//         ),
//       );
//     } catch (e) {
//       return Left(ApiFailure(statusCode: 500, message: e.toString()));
//     }
//   }

//   @override
//   Future<Either<Failure, String>> loginUser(
//     String mobile,
//     String password,
//   ) async {
//     try {
//       final token = await remoteDataSource.loginUser(mobile, password);

//       // Save token locally if TokenSharedPrefs is provided
//       if (tokenSharedPrefs != null) {
//         await tokenSharedPrefs!.saveToken(token);
//       }

//       return Right(token);
//     } on DioException catch (e) {
//       return Left(
//         ApiFailure(
//           statusCode: e.response?.statusCode ?? 500,
//           message: e.response?.data.toString() ?? e.message ?? 'Login failed',
//         ),
//       );
//     } catch (e) {
//       return Left(ApiFailure(statusCode: 500, message: e.toString()));
//     }
//   }
// }

import 'package:cura_pet/features/user/data/data_source/remote_datasource/user_remote_data_source.dart';
import 'package:cura_pet/features/user/domain/entity/user_entity.dart';
import 'package:cura_pet/features/user/domain/repository/user_repository.dart';
import 'package:cura_pet/app/shared_pref/token_shared_prefs.dart';
import 'package:cura_pet/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class UserRemoteRepository implements IUserRepository {
  final UserRemoteDataSource remoteDataSource;
  final TokenSharedPrefs? tokenSharedPrefs;

  UserRemoteRepository({required this.remoteDataSource, this.tokenSharedPrefs});

  @override
  Future<Either<Failure, void>> registerUser(UserEntity user) async {
    try {
      await remoteDataSource.registerUser(user);
      return const Right(null);
    } on DioException catch (e) {
      return Left(
        ApiFailure(
          statusCode: e.response?.statusCode ?? 500,
          message:
              e.response?.data.toString() ?? e.message ?? 'Registration failed',
        ),
      );
    } catch (e) {
      return Left(ApiFailure(statusCode: 500, message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginUser(
    String email,
    String password,
  ) async {
    try {
      final token = await remoteDataSource.loginUser(email, password);
      if (tokenSharedPrefs != null) {
        await tokenSharedPrefs!.saveToken(token);
      }
      return Right(token);
    } on DioException catch (e) {
      return Left(
        ApiFailure(
          statusCode: e.response?.statusCode ?? 500,
          message: e.response?.data.toString() ?? e.message ?? 'Login failed',
        ),
      );
    } catch (e) {
      return Left(ApiFailure(statusCode: 500, message: e.toString()));
    }
  }
}
