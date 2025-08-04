import 'package:cura_pet/features/home/presentation/view/home_page.dart';
import 'package:flutter/material.dart';

class SimpleLoginPage extends StatefulWidget {
  const SimpleLoginPage({super.key});

  @override
  State<SimpleLoginPage> createState() => _SimpleLoginPageState();
}

class _SimpleLoginPageState extends State<SimpleLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Login Successful!')));

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with 0.40 opacity
          Opacity(
            opacity: 0.40,
            child: Image.asset(
              'assets/Paw.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // Foreground content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/CURA PET.png'),
                    ),
                    const SizedBox(height: 20),

                    // Name field
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator:
                          (value) =>
                              value == null || value.isEmpty
                                  ? 'Enter your name'
                                  : null,
                    ),
                    const SizedBox(height: 20),

                    // Password field
                    TextFormField(
                      controller: passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                      ),
                      validator:
                          (value) =>
                              (value == null || value.length < 6)
                                  ? 'Password must be at least 6 characters'
                                  : null,
                    ),
                    const SizedBox(height: 30),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _onLogin,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: Colors.cyan,
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
