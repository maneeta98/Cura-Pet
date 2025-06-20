import 'package:cura_pet/bottom/about_screen.dart';
import 'package:cura_pet/bottom/appointment_screen.dart';
import 'package:cura_pet/bottom/notices_screen.dart';
import 'package:cura_pet/bottom/profile_screen.dart';
import 'package:cura_pet/view/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/service_locator/service_locator.dart';
import '../../features/home/view_model/home_view_model.dart';

class BottomNavigationState {
  final int currentIndex;
  final List<Widget> screens;

  BottomNavigationState({required this.currentIndex})
    : screens = [
        //  Dashboard (Home)
        BlocProvider<HomeViewModel>.value(
          value: serviceLocator<HomeViewModel>(),
          child: const DashboardCard(title: '', icon: Icons.import_contacts),
        ),
        //  Appointment Booking
        const AppointmentScreen(),
        //  Notices
        const NoticesScreen(),
        //  About
        const AboutScreen(),
        //  Profile
        const ProfileScreen(),
      ];

  Widget get currentScreen => screens[currentIndex];
}
