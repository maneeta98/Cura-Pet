import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Wait 3 seconds before navigating to the next screen
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login'); // or '/home'
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Image (replace with your asset path)
            Image.asset('assets/CURA PET.png', height: 120),
            const SizedBox(height: 20),
            // App Name
            const Text(
              'CURA PET',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your Pet Health, Our Expertise',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 40),
            // Loading Indicator
            const CircularProgressIndicator(color: Colors.teal),
          ],
        ),
      ),
    );
  }
}
