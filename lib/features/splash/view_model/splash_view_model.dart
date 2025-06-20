import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class SplashViewModel extends Cubit<void> {
  SplashViewModel() : super(null);

  void startTimer(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
  }
}
