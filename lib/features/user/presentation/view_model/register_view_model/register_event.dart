import 'package:flutter/cupertino.dart';

@immutable
sealed class RegisterEvent {}

/// Triggered when user wants to navigate to Login page
class NavigateToLoginEvent extends RegisterEvent {
  final BuildContext context;

  NavigateToLoginEvent({required this.context});
}

/// Triggered when user submits registration form
class RegisterUserEvent extends RegisterEvent {
  final BuildContext context;
  final String name;
  final String password;
  final String email;
  final String phone;

  RegisterUserEvent({
    required this.context,
    required this.name,
    required this.password,
    required this.phone,
    required this.email,
  });
}
