// lib/bloc/home_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  void loadHomeData() async {
    emit(HomeLoading());

    await Future.delayed(const Duration(seconds: 2)); // simulate network delay

    try {
      // Simulate success
      emit(HomeLoaded("Welcome to CuraPet Home!"));
    } catch (e) {
      emit(HomeError("Failed to load home data."));
    }
  }
}
