import 'package:cura_pet/app/usecase/use_case.dart';
import 'package:cura_pet/core/error/failure.dart';
import 'package:cura_pet/features/user/domain/entity/user_entity.dart';
import 'package:cura_pet/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterUserParams extends Equatable {
  final String name;
  final String phone;
  final String password;
  final String email;

  const RegisterUserParams({
    required this.name,
    required this.password,
    required this.email,
    required this.phone,
  });

  @override
  List<Object?> get props => [name, phone, password, email];
}

class UserRegisterUseCase
    implements UseCaseWithParams<void, RegisterUserParams> {
  final IUserRepository _userRepository;

  UserRegisterUseCase(
    MockUserRegisterRepository repository, {
    required IUserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<Either<Failure, void>> call(RegisterUserParams params) {
    final userEntity = UserEntity(
      name: params.name,
      email: params.email,
      password: params.password,
      phone: params.phone,
    );

    return _userRepository.registerUser(userEntity);
  }
}

class MockUserRegisterRepository {}
