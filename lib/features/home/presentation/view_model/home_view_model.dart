import 'package:cura_pet/features/home/presentation/view_model/home_state.dart';
import 'package:cura_pet/features/user/presentation/view/login_view.dart';
import 'package:cura_pet/features/user/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeViewModel extends Cubit<HomeState> {
  HomeViewModel({required this.loginViewModel}) : super(HomeState.initial());

  final LoginViewModel loginViewModel;

  void onTabTapped(int index) {
    emit(state.copyWith(selectedIndex: index));
  }

  void logout(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => BlocProvider.value(
                  value: loginViewModel,
                  child: LoginView(),
                ),
          ),
        );
      }
    });
  }
}
