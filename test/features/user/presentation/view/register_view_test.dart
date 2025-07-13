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

class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  late MockUserRegisterUseCase mockRegisterUseCase;
  late RegisterViewModel registerViewModel;

  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
  });

  setUp(() {
    mockRegisterUseCase = MockUserRegisterUseCase();
    registerViewModel = RegisterViewModel(mockRegisterUseCase);
  });

  group('RegisterViewModel', () {
    blocTest<RegisterViewModel, RegisterState>(
      'emits loading and success state on successful registration',
      build: () {
        when(
          () => mockRegisterUseCase.call(any()),
        ).thenAnswer((_) async => const Right(null));
        return registerViewModel;
      },
      act:
          (bloc) => bloc.add(
            RegisterUserEvent(
              email: 'test@gmail.com',
              name: 'Test',
              phone: '9800000000',
              password: 'password',
              context: FakeBuildContext(),
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
