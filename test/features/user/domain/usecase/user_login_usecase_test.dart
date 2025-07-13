import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
import 'package:cura_pet/features/user/domain/usecase/user_login_usecase.dart';
import 'package:cura_pet/features/user/domain/entity/user_entity.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cura_pet/core/error/failure.dart';

class MockLoginRepository extends Mock implements UserLoginUseCase {}

void main() {
  late UserLoginUseCase usecase;
  setUp(() {
    usecase = MockLoginRepository();
  });

  test('should return token when login is successful', () async {
    when(
      () => usecase.call(any()),
    ).thenAnswer((_) async => const Right("token_123"));

    final result = await usecase(
      LoginParams(email: "test@gmail.com", password: "pass123"),
    );

    expect(result, const Right("token_123"));
    verify(() => usecase.call(any())).called(1);
  });

  test('should return failure when login fails', () async {
    when(() => usecase.call(any())).thenAnswer(
      (_) async => Left(ApiFailure(message: 'Invalid', statusCode: 401)),
    );

    final result = await usecase(LoginParams(email: "wrong", password: "fail"));

    expect(result, isA<Left>());
  });
}
