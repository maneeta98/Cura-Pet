// // import 'package:flutter/material.dart';

// // class RegisterView extends StatelessWidget {
// //   const RegisterView({Key? key}) : super(key: key); // Use const constructor

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text("Register")),
// //       body: const Center(child: Text("This is the Register Screen")),
// //     );
// //   }
// // }
// // import 'package:flutter/material.dart';

// // class RegisterPage extends StatefulWidget {
// //   const RegisterPage({super.key});

// //   @override
// //   State<RegisterPage> createState() => _RegisterPageState();
// // }

// // class _RegisterPageState extends State<RegisterPage> {
// //   final _formKey = GlobalKey<FormState>();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Register')),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Form(
// //           key: _formKey,
// //           child: ListView(
// //             children: [
// //               Image.asset('assets/CURA PET.png', height: 100),
// //               const SizedBox(height: 20),
// //               TextFormField(
// //                 decoration: const InputDecoration(labelText: 'Name'),
// //               ),
// //               TextFormField(
// //                 decoration: const InputDecoration(labelText: 'Email'),
// //               ),
// //               TextFormField(
// //                 decoration: const InputDecoration(labelText: 'Password'),
// //                 obscureText: true,
// //               ),
// //               const SizedBox(height: 20),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   // Navigator.pushReplacementNamed(context, '/dashboard');
// //                 },
// //                 child: const Text('Register'),
// //               ),
// //               TextButton(
// //                 onPressed: () => Navigator.pushNamed(context, '/login'),
// //                 child: const Text('Already have an account? Login'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // import 'package:flutter/material.dart';

// // class RegisterPage extends StatefulWidget {
// //   const RegisterPage({super.key});

// //   @override
// //   State<RegisterPage> createState() => _RegisterPageState();
// // }

// // class _RegisterPageState extends State<RegisterPage> {
// //   final _formKey = GlobalKey<FormState>();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: const Text('Register')),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Form(
// //           key: _formKey,
// //           child: ListView(
// //             children: [
// //               Image.asset('assets/CURA PET.png', height: 100),
// //               const SizedBox(height: 20),
// //               TextFormField(
// //                 decoration: const InputDecoration(labelText: 'Name'),
// //               ),
// //               TextFormField(
// //                 decoration: const InputDecoration(labelText: 'Email'),
// //               ),
// //               TextFormField(
// //                 decoration: const InputDecoration(labelText: 'Password'),
// //                 obscureText: true,
// //               ),
// //               const SizedBox(height: 20),
// //               ElevatedButton(
// //                 onPressed: () {
// //                   // Registration logic
// //                 },
// //                 child: const Text('Register'),
// //               ),
// //               const SizedBox(height: 10),
// //               TextButton(
// //                 onPressed: () {
// //                   Navigator.pushReplacementNamed(context, '/login');
// //                 },
// //                 child: const Text('Already have an account? Login'),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:cura_pet/features/user/presentation/view/login_view.dart'; // Import your LoginViewScreen

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final _formKey = GlobalKey<FormState>();
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   @override
//   void dispose() {
//     nameController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   void _onRegister() {
//     if (_formKey.currentState!.validate()) {
//       // After successful registration navigate to login
//       Navigator.pushReplacementNamed(context, '/login');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Register')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               Image.asset('assets/CURA PET.png', height: 100),
//               const SizedBox(height: 20),

//               // Name
//               TextFormField(
//                 controller: nameController,
//                 decoration: const InputDecoration(labelText: 'Name'),
//                 validator:
//                     (value) =>
//                         value == null || value.isEmpty
//                             ? 'Enter your name'
//                             : null,
//               ),

//               // Email
//               TextFormField(
//                 controller: emailController,
//                 decoration: const InputDecoration(labelText: 'Email'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Enter your email';
//                   } else if (!value.contains('@')) {
//                     return 'Enter a valid email';
//                   }
//                   return null;
//                 },
//               ),

//               // Password
//               TextFormField(
//                 controller: passwordController,
//                 decoration: const InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 validator:
//                     (value) =>
//                         (value == null || value.length < 6)
//                             ? 'Password must be at least 6 characters'
//                             : null,
//               ),

//               const SizedBox(height: 20),

//               // Register Button
//               ElevatedButton(
//                 onPressed: _onRegister,
//                 child: const Text('Register'),
//               ),

//               const SizedBox(height: 20),

//               // Row: Already have an account? Login
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Text("Already have an account?"),
//                   const SizedBox(width: 5),
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const LoginView(),
//                         ),
//                       );
//                     },
//                     child: const Text(
//                       "Login",
//                       style: TextStyle(
//                         color: Colors.deepPurple,
//                         fontWeight: FontWeight.bold,
//                         decoration: TextDecoration.underline,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cura_pet/features/user/presentation/view/simple_login_page.dart';
import 'package:flutter/material.dart';
import 'package:cura_pet/features/user/presentation/view/login_view.dart'; // import your login page

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _onRegister() {
    if (_formKey.currentState!.validate()) {
      // Navigate to Login page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginView()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Stack(
        children: [
          // Background image with mid transparency
          Opacity(
            opacity: 0.40,
            child: Image.asset(
              'assets/Paw.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          // Foreground form
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Image.asset('assets/CURA PET.png', height: 100),
                  const SizedBox(height: 20),

                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator:
                        (value) =>
                            (value == null || value.isEmpty)
                                ? 'Enter your name'
                                : null,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator:
                        (value) =>
                            (value == null || value.length < 6)
                                ? 'Password must be at least 6 characters'
                                : null,
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: _onRegister,
                    child: const Text('Register'),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SimpleLoginPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
