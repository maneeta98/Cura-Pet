import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Your imports
import 'package:cura_pet/features/user/domain/usecase/user_login_usecase.dart';
import 'package:cura_pet/features/user/domain/repository/user_repository.dart';
import 'package:cura_pet/core/error/failure.dart';

// Mock repository
class MockUserRepository extends Mock implements IUserRepository {}

void main() {
  late MockUserRepository mockUserRepository;
  late UserLoginUseCase loginUseCase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    loginUseCase = UserLoginUseCase(userRepository: mockUserRepository);
  });

  test('should return token on successful login', () async {
    const email = 'manita@example.com';
    const password = 'test123';
    const token = 'token_123';

    // Arrange
    when(
      mockUserRepository.loginUser(email, password),
    ).thenAnswer((_) async => const Right(token));

    // Act
    final result = await loginUseCase(
      const LoginParams(email: email, password: password),
    );

    // Assert
    expect(result, const Right(token));
    verify(mockUserRepository.loginUser(email, password)).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });

  test('should return Failure on login error', () async {
    const email = 'manita@example.com';
    const password = 'test123';
    final failure = ServerFailure('Login failed');

    when(
      mockUserRepository.loginUser(email, password),
    ).thenAnswer((_) async => Left(failure));

    final result = await loginUseCase(
      const LoginParams(email: email, password: password),
    );

    expect(result, Left(failure));
    verify(mockUserRepository.loginUser(email, password)).called(1);
    verifyNoMoreInteractions(mockUserRepository);
  });
}

// Minimal Failure base class
abstract class Failure {
  final String message;
  Failure({required this.message});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;
}

// Your ServerFailure extending Failure
class ServerFailure extends Failure {
  ServerFailure(String message) : super(message: message);
}
