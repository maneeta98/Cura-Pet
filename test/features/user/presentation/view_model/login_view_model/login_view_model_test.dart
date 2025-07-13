import 'package:bloc_test/bloc_test.dart';
import 'package:cura_pet/features/user/domain/usecase/user_register_usecase.dart';
import 'package:cura_pet/features/user/presentation/view_model/register_view_model/register_event.dart';
import 'package:cura_pet/features/user/presentation/view_model/register_view_model/register_state.dart';
import 'package:cura_pet/features/user/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRegisterUseCase extends Mock implements UserRegisterUseCase {}

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockUserRegisterUseCase mockRegisterUseCase;
  late RegisterViewModel registerViewModel;
  late MockBuildContext mockContext;

  setUp(() {
    mockRegisterUseCase = MockUserRegisterUseCase();
    registerViewModel = RegisterViewModel(mockRegisterUseCase);
    mockContext = MockBuildContext();
  });

  group('RegisterViewModel', () {
    blocTest<RegisterViewModel, RegisterState>(
      'emits loading and success on RegisterUserEvent',
      build: () {
        when(
          () => mockRegisterUseCase.call(any()),
        ).thenAnswer((_) async => const Right(null));
        return registerViewModel;
      },
      act:
          (bloc) => bloc.add(
            RegisterUserEvent(
              email: 'manita@example.com',
              name: 'Manita',
              phone: '9812345678',
              password: 'test123',
              context: mockContext, // ✅ Use mock context here
            ),
          ),
      expect:
          () => [
            RegisterState.initial().copyWith(isLoading: true),
            RegisterState.initial().copyWith(isLoading: false, isSuccess: true),
          ],
      verify: (_) {
        verify(() => mockRegisterUseCase.call(any())).called(1);
      },
    );
  });
}
