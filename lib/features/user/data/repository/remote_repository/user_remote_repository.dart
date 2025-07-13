import 'package:cura_pet/core/network/remote/api_service.dart';
import 'package:cura_pet/app/constant/remote/api_endpoints.dart';
import 'package:cura_pet/features/user/data/model/user_api_model.dart';
import 'package:cura_pet/features/user/domain/entity/user_entity.dart';

class UserRemoteDataSource {
  final ApiService _apiService;

  UserRemoteDataSource({required ApiService apiService})
    : _apiService = apiService;

  Future<void> registerUser(UserEntity user) async {
    final model = UserApiModel.fromEntity(user);
    await _apiService.dio.post(ApiEndpoints.register, data: model.toJson());
  }

  Future<String> loginUser(String mobile, String password) async {
    final response = await _apiService.dio.post(
      ApiEndpoints.login,
      data: {'mobile': mobile, 'password': password},
    );

    return response.data['token'] as String;
  }
}
