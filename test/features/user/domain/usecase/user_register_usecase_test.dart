import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Your imports
import 'package:cura_pet/features/user/domain/entity/user_entity.dart';
import 'package:cura_pet/features/user/domain/repository/user_repository.dart';
import 'package:cura_pet/features/user/domain/usecase/user_register_usecase.dart';

// Mock class
class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository mockUserRepository;
  late UserRegisterUseCase registerUseCase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    registerUseCase = UserRegisterUseCase(
      mockUserRepository as MockUserRegisterRepository,
      userRepository: null,
    );
  });

  test('should return Right(null) when registration succeeds', () async {
    final user = UserEntity(
      name: 'Manita',
      email: 'manita@example.com',
      phone: '9812345678',
      password: 'test123',
    );

    when(
      mockUserRepository.registerUser(any()),
    ).thenAnswer((_) async => const Right(null));

    final params = RegisterUserParams(
      name: user.name,
      email: user.email,
      phone: user.phone,
      password: user.password,
    );

    // Call usecase method correctly
    final result = await registerUseCase.call(params);

    expect(result, const Right(null));

    verify(
      mockUserRepository.registerUser(
        argThat(
          predicate<UserEntity>(
            (u) =>
                u.name == user.name &&
                u.email == user.email &&
                u.phone == user.phone &&
                u.password == user.password,
          ),
        ),
      ),
    ).called(1);

    verifyNoMoreInteractions(mockUserRepository);
  });
}
