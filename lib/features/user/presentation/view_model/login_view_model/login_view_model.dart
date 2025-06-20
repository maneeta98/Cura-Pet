import 'package:cura_pet/bottom/home_screen.dart';
import 'package:cura_pet/core/common/my_snackbar.dart';
import 'package:cura_pet/cubit/bottom_navigation_cubit.dart';
import 'package:cura_pet/features/user/domain/usecase/user_login_usecase.dart';
import 'package:cura_pet/features/user/presentation/view/signup_view.dart';
import 'package:cura_pet/features/user/presentation/view_model/login_view_model/login_event.dart';
import 'package:cura_pet/features/user/presentation/view_model/login_view_model/login_state.dart';
import 'package:cura_pet/features/user/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/service_locator/service_locator.dart';

class LoginViewModel extends Bloc<LoginEvent, LoginState> {
  final UserLoginUseCase _userLoginUseCase;

  LoginViewModel(this._userLoginUseCase) : super(LoginState.initial()) {
    on<NavigateToRegisterView>(_onNavigateToRegisterView);
    on<NavigateToHomeView>(_onNavigateToHomeView);
    on<LoginWithEmailAndPassword>(_onLoginWithEmailAndPassword);
  }

  void _onNavigateToRegisterView(
    NavigateToRegisterView event,
    Emitter<LoginState> emit,
  ) {
    if (event.context.mounted) {
      Navigator.push(
        event.context,
        MaterialPageRoute(
          builder:
              (_) => BlocProvider.value(
                value: serviceLocator<RegisterViewModel>(),
                child: const SignupView(),
              ),
        ),
      );
    }
  }

  void _onNavigateToHomeView(
    NavigateToHomeView event,
    Emitter<LoginState> emit,
  ) {
    Navigator.pushAndRemoveUntil(
      event.context,
      MaterialPageRoute(
        builder:
            (_) => BlocProvider(
              create: (_) => BottomNavigationCubit(),
              child: const HomeScreen(showSnackbar: true),
            ),
      ),
      (route) => false,
    );
  }

  void _onLoginWithEmailAndPassword(
    LoginWithEmailAndPassword event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    final result = await _userLoginUseCase(
      LoginParams(email: event.email.trim(), password: event.password.trim()),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
          context: event.context,
          message: 'Invalid credentials. Please try again.',
          color: Colors.red,
        );
      },
      (_) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        add(NavigateToHomeView(context: event.context));
      },
    );
  }
}
