import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class AppFlushbar {
  static Future<void> show({
    required BuildContext context,
    required String message,
    Color backgroundColor = const Color(0xFF89C158), // CuraPet Green
    Icon? icon,
    Duration duration = const Duration(seconds: 2),
  }) {
    return Flushbar(
      message: message,
      messageColor: Colors.white,
      backgroundColor: backgroundColor,
      duration: duration,
      borderRadius: BorderRadius.circular(16),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      flushbarPosition: FlushbarPosition.BOTTOM,
      animationDuration: const Duration(milliseconds: 600),
      forwardAnimationCurve: Curves.easeInOut,
      reverseAnimationCurve: Curves.easeInOut,
      icon: icon ?? const Icon(Icons.pets, color: Colors.white, size: 28),
    ).show(context);
  }
}
