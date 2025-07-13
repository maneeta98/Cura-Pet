import 'package:flutter/material.dart';

abstract class LoginEvent {}

class NavigateToRegisterView extends LoginEvent {
  final BuildContext context;
  NavigateToRegisterView({required this.context});
}

class NavigateToHomeView extends LoginEvent {
  final BuildContext context;
  NavigateToHomeView({required this.context});
}

class LoginWithEmailAndPassword extends LoginEvent {
  final String email;
  final String password;
  final BuildContext context;
  LoginWithEmailAndPassword({
    required this.email,
    required this.password,
    required this.context,
  });
}
