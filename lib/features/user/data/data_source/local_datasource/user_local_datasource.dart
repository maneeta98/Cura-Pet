import 'package:cura_pet/core/network/local/hive_service.dart';
import 'package:cura_pet/features/user/data/data_source/user_data_source.dart';
import 'package:cura_pet/features/user/data/model/user_hive_model.dart';
import 'package:cura_pet/features/user/domain/entity/user_entity.dart';

class UserLocalDataSource implements IUserDataSource {
  final HiveService _hiveService;

  UserLocalDataSource({required HiveService hiveService})
    : _hiveService = hiveService;

  @override
  Future<String> loginUser(String email, String password) async {
    try {
      final userData = await _hiveService.login(email, password);
      if (userData != null) {
        // Password check already done in HiveService.login
        return "Login successful";
      } else {
        throw Exception('Invalid email or password');
      }
    } catch (e) {
      throw Exception('Login Failed: $e');
    }
  }

  @override
  Future<void> registerUser(UserEntity entity) async {
    try {
      final userHiveModel = UserHiveModel.fromEntity(entity);
      await _hiveService.register(userHiveModel);
    } catch (e) {
      throw Exception("Registration Failed: $e");
    }
  }
}
