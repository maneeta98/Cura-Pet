import 'package:cura_pet/app/service_locator/service_locator.dart';
import 'package:cura_pet/features/user/domain/usecase/user_register_usecase.dart';
import 'package:cura_pet/features/user/presentation/view/login_view.dart';
import 'package:cura_pet/features/user/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:cura_pet/features/user/presentation/view_model/register_view_model/register_event.dart';
import 'package:cura_pet/features/user/presentation/view_model/register_view_model/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterViewModel extends Bloc<RegisterEvent, RegisterState> {
  final UserRegisterUseCase _userRegisterUseCase;

  RegisterViewModel(this._userRegisterUseCase)
    : super(RegisterState.initial()) {
    on<RegisterUserEvent>(_onRegisterUser);
    on<NavigateToLoginEvent>(_onNavigateToLoginEvent);
  }

  get AppFlushbar => null;

  Future<void> _onRegisterUser(
    RegisterUserEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    // Optional delay for UX or testing
    await Future.delayed(const Duration(seconds: 1));

    // Debug print
    print('📝 Submitted Data:');
    print('Name: ${event.name}');
    print('Email: ${event.email}');
    print('Password: ${event.password}');
    print('Phone: ${event.phone}');

    final result = await _userRegisterUseCase(
      RegisterUserParams(
        email: event.email,
        name: event.name,
        password: event.password,
        phone: event.phone,
      ),
    );

    result.fold(
      (failure) async {
        emit(state.copyWith(isLoading: false));

        if (event.context.mounted) {
          await AppFlushbar.show(
            context: event.context,
            message: "Something went wrong!",
            icon: const Icon(Icons.error, color: Colors.white),
            backgroundColor: Colors.red, // Typically error color is red
          );
        }
      },
      (success) async {
        emit(state.copyWith(isLoading: false, isSuccess: true));

        if (event.context.mounted) {
          Navigator.pushReplacement(
            event.context,
            MaterialPageRoute(
              builder:
                  (context) => BlocProvider.value(
                    value: serviceLocator<LoginViewModel>(),
                    child: const LoginView(),
                  ),
            ),
          );
          await AppFlushbar.show(
            context: event.context,
            message: "Signup successful!",
            icon: const Icon(Icons.check_circle, color: Colors.white),
            backgroundColor: Colors.green, // Success color green
          );
        }
      },
    );
  }

  void _onNavigateToLoginEvent(
    NavigateToLoginEvent event,
    Emitter<RegisterState> emit,
  ) {
    if (event.context.mounted) {
      Navigator.pushReplacement(
        event.context,
        MaterialPageRoute(
          builder:
              (context) => BlocProvider.value(
                value: serviceLocator<LoginViewModel>(),
                child: const LoginView(),
              ),
        ),
      );
    }
  }
}
