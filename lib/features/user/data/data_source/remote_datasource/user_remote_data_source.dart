// import 'package:cura_pet/features/user/data/data_source/user_data_source.dart';
// import 'package:cura_pet/features/user/domain/entity/user_entity.dart';
// import 'package:dio/dio.dart';

// class UserRemoteDataSource implements IUserDataSource {
//   final ApiService _apiService;

//   UserRemoteDataSource({required ApiService apiService}) : _apiService = apiService;

//   @override
//   Future<String> loginUser(String email, String password) async {
//     try {
//       final response = await _apiService.dio.post(
//         ApiEndpoints.login,
//         data: {'email': email, 'password': password},
//       );

//       if (response.statusCode == 200 && response.data != null) {
//         // Assuming backend returns a token string on successful login
//         final token = response.data['token'] as String?;
//         if (token != null && token.isNotEmpty) {
//           return token;
//         } else {
//           throw Exception('Login failed: Token not received');
//         }
//       } else {
//         throw Exception("Login failed: ${response.statusMessage}");
//       }
//     } on DioException catch (e) {
//       throw Exception("Login failed: ${e.message}");
//     } catch (e) {
//       throw Exception("Login failed: $e");
//     }
//   }

//   @override
//   Future<void> registerUser(UserEntity entity) async {
//     try {
//       final userApiModel = UserApiModel.fromEntity(entity);
//       final response = await _apiService.dio.post(
//         ApiEndpoints.register,
//         data: userApiModel.toJson(),
//       );
//       if (response.statusCode != 200) {
//         throw Exception("Registration failed: ${response.statusMessage}");
//       }
//     } on DioException catch (e) {
//       throw Exception("Registration failed: ${e.message}");
//     } catch (e) {
//       throw Exception('Registration failed: $e');
//     }
//   }

//   @override
//   Future<void> deleteUser(String id) {
//     // TODO: Implement delete user API call
//     throw UnimplementedError('deleteUser() is not implemented yet');
//   }

//   @override
//   Future<List<UserEntity>> getAllUser() {
//     // TODO: Implement get all users API call
//     throw UnimplementedError('getAllUser() is not implemented yet');
//   }

//   Future<void> createUser(UserEntity user) async {}
// }
