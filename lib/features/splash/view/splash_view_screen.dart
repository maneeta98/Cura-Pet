// splash_view_screen.dart
import 'package:cura_pet/features/splash/view_model/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashViewScreen extends StatefulWidget {
  const SplashViewScreen({super.key});

  @override
  State<SplashViewScreen> createState() => _SplashViewScreenState();
}

class _SplashViewScreenState extends State<SplashViewScreen> {
  late SplashViewModel splashViewModel;

  @override
  void initState() {
    super.initState();
    splashViewModel = SplashViewModel();
    splashViewModel.startTimer(context);
  }

  @override
  void dispose() {
    splashViewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: splashViewModel,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/CURA PET.png', height: 130),
              const SizedBox(height: 20),
              const Text(
                'CURA PET',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Your Pet Health, Our Expertise',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 40),
              const CircularProgressIndicator(color: Colors.teal),
            ],
          ),
        ),
      ),
    );
  }
}
