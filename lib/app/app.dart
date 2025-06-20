import 'package:cura_pet/app/service_locator/service_locator.dart';
import 'package:cura_pet/bottom/dashboard.dart';
import 'package:cura_pet/features/splash/view/splash_view_screen.dart';
import 'package:cura_pet/features/splash/view_model/splash_view_model.dart';
import 'package:cura_pet/features/user/presentation/view/login_view.dart'; // Import your login screen here
import 'package:cura_pet/theme/theme_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      home: BlocProvider.value(
        value: serviceLocator<SplashViewModel>(),
        child: const SplashViewScreen(),
      ),
      routes: {
        '/login': (context) => const LoginView(), // Login route
        '/dashboard':
            (context) => const DashboardScreen(), // Dashboard route if needed
      },
    );
  }
}
