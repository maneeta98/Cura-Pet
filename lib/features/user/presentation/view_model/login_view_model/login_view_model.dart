import 'package:bloc/bloc.dart';
import 'package:cura_pet/features/user/domain/usecase/user_login_usecase.dart';
import 'package:cura_pet/features/user/presentation/view_model/login_view_model/login_event.dart';
import 'package:cura_pet/features/user/presentation/view_model/login_view_model/login_state.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  final UserLoginUseCase loginUserUseCase;

  LoginViewModel(MockLoginUseCase mockUseCase, {required this.loginUserUseCase})
    : super(const LoginState()) {
    on<LoginWithEmailAndPassword>(_onLoginWithEmailAndPassword);
  }

  Future<void> _onLoginWithEmailAndPassword(
    LoginWithEmailAndPassword event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await loginUserUseCase(
      LoginParams(email: event.email, password: event.password),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        ScaffoldMessenger.of(
          event.context,
        ).showSnackBar(SnackBar(content: Text(failure.message)));
      },
      (token) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
      },
    );
  }
}

class MockLoginUseCase {}
