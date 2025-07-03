// ✅ login_view.dart

import 'package:cura_pet/app/service_locator/service_locator.dart';
import 'package:cura_pet/features/user/presentation/view/signup_view.dart';
import 'package:cura_pet/features/user/presentation/view_model/login_view_model/login_event.dart';
import 'package:cura_pet/features/user/presentation/view_model/login_view_model/login_state.dart';
import 'package:cura_pet/features/user/presentation/view_model/login_view_model/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _showSnackBar(String message, {bool isError = true}) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginViewModel>(
      create: (_) => serviceLocator<LoginViewModel>(),
      child: BlocConsumer<LoginViewModel, LoginState>(
        listener: (context, state) {
          if (state.isSuccess) {
            _showSnackBar("Login Successful!", isError: false);
          } else if (state.errorMessage != null) {
            _showSnackBar(state.errorMessage!);
          }
        },
        builder: (context, state) {
          final bloc = context.read<LoginViewModel>();

          return Scaffold(
            body: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset('assets/Dog.jpg', fit: BoxFit.cover),
                Container(color: Colors.black.withOpacity(0.7)),
                SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 300,
                  ),
                  child: Form(
                    key: formKey,
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Welcome!",
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 40),
                            TextFormField(
                              controller: emailController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.black38,
                                labelText: "Email Address",
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                hintText: "Enter your email",
                                hintStyle: const TextStyle(
                                  color: Colors.white70,
                                ),
                                prefixIcon: const Icon(
                                  Icons.email,
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your email address";
                                } else if (!value.contains('@')) {
                                  return "Please enter a valid email";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 20),

                            TextFormField(
                              controller: passwordController,
                              obscureText: _obscurePassword,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.black38,
                                labelText: "Password",
                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscurePassword = !_obscurePassword;
                                    });
                                  },
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please enter your password";
                                } else if (value.length < 6) {
                                  return "Password must be at least 6 characters";
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 10),

                            Row(
                              children: [
                                Checkbox(
                                  value: rememberMe,
                                  onChanged: (val) {
                                    setState(() {
                                      rememberMe = val ?? false;
                                    });
                                  },
                                  checkColor: Colors.black,
                                  activeColor: Colors.white,
                                ),
                                const Text(
                                  "Remember me",
                                  style: TextStyle(color: Colors.white),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF89C158),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed:
                                    state.isLoading
                                        ? null
                                        : () {
                                          if (formKey.currentState!
                                              .validate()) {
                                            bloc.add(
                                              LoginWithEmailAndPassword(
                                                context: context,
                                                email:
                                                    emailController.text.trim(),
                                                password:
                                                    passwordController.text
                                                        .trim(),
                                              ),
                                            );
                                          }
                                        },
                                child: const Text(
                                  "Sign In",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const SignupView(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Don't have an account? Sign up",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        if (state.isLoading)
                          Positioned.fill(
                            child: Container(
                              color: Colors.black45,
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// ✅ No NavigateToRegisterView used. Direct Navigator.push is used for Signup navigation.
// ✅ Login button triggers bloc event correctly.
// ✅ Loading spinner works.
