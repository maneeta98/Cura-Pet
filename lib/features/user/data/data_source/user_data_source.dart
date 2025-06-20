import 'package:cura_pet/features/user/domain/entity/user_entity.dart';

abstract class IUserDataSource {
  Future<void> loginUser(String email, String password);

  Future<void> registerUser(UserEntity entity);
}
