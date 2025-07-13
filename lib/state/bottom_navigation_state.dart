import 'package:cura_pet/app/service_locator/service_locator.dart';
import 'package:cura_pet/bottom/appointment_screen.dart';
import 'package:cura_pet/bottom/profile_screen.dart';
import 'package:cura_pet/features/home/presentation/view/home_view.dart';

import 'package:cura_pet/features/pets/presentation/pets_view.dart';
import 'package:cura_pet/features/home/presentation/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationState {
  final int currentIndex;
  final List<Widget> screens;

  BottomNavigationState({required this.currentIndex})
    : screens = [
        BlocProvider<HomeViewModel>.value(
          value: serviceLocator<HomeViewModel>(),
          child: HomeView(),
        ),
        const PetsView(), // 🐾 Pets Feature
        const AppointmentScreen(), // 📅 Appointments Feature
        const ProfileScreen(), // 👤 Profile Feature
      ];

  Widget get currentScreen => screens[currentIndex];
}
