import 'package:cura_pet/app/usecase/use_case.dart';
import 'package:cura_pet/core/error/failure.dart';
import 'package:cura_pet/features/user/domain/repository/user_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class UserLoginUseCase implements UseCaseWithParams<String, LoginParams> {
  final IUserRepository _userRepository;

  UserLoginUseCase(
    MockUserRepository mockUserRepository, {
    required IUserRepository userRepository,
  }) : _userRepository = userRepository;

  @override
  Future<Either<Failure, String>> call(LoginParams params) {
    return _userRepository.loginUser(params.email, params.password);
  }
}

class MockUserRepository {
  loginUser(String email, String password) {}
}
