import 'package:cura_pet/app/service_locator/service_locator.dart';
import 'package:cura_pet/features/home/presentation/view/home_view.dart';
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

  void _showSnackBar(String message, [bool isError = true]) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: isError ? Colors.red : Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<LoginViewModel>(),
      child: BlocConsumer<LoginViewModel, LoginState>(
        listener: (context, state) {
          if (state.isSuccess) {
            _showSnackBar("Login Successful!", false);
            // TODO: Navigate to dashboard/home screen
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
                                color: Color.fromARGB(255, 251, 251, 252),
                              ),
                            ),
                            const SizedBox(height: 40),

                            // Email TextField
                            TextFormField(
                              controller: emailController,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.black38,
                                labelText: "Email Address",
                                hintText: "Enter your email",
                                hintStyle: const TextStyle(
                                  color: Colors.white70,
                                ),
                                labelStyle: const TextStyle(
                                  color: Colors.white,
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

                            // Password TextField
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

                            // Remember me and Forgot password
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
                                  onPressed: () {
                                    // TODO: Implement forgot password
                                  },
                                  child: const Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: Color.fromRGBO(243, 243, 243, 1),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Sign In button
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color.fromARGB(
                                    135,
                                    27,
                                    40,
                                    215,
                                  ),
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
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => HomeView(),
                                            ),
                                          );
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

                            // Navigate to Signup
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  bloc.add(
                                    NavigateToRegisterView(context: context),
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

                        // Loading Indicator
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
