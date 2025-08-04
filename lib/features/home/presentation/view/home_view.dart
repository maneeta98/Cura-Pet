// import 'package:cura_pet/features/home/presentation/view/home_page.dart';
// import 'package:flutter/material.dart';

// class SimpleLoginPage extends StatefulWidget {
//   const SimpleLoginPage({super.key});

//   @override
//   State<SimpleLoginPage> createState() => _SimpleLoginPageState();
// }

// class _SimpleLoginPageState extends State<SimpleLoginPage> {
//   final _formKey = GlobalKey<FormState>();
//   final nameController = TextEditingController();
//   final passwordController = TextEditingController();
//   bool _obscurePassword = true;

//   @override
//   void dispose() {
//     nameController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   void _onLogin() {
//     if (_formKey.currentState!.validate()) {
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Login Successful!')));

//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomePage()),
//       );
//     }
//   }

//   final List<Map<String, dynamic>> featuredPets = const [
//     {
//       'name': 'Bella',
//       'breed': 'Golden Retriever',
//       'age': 3,
//       'imageUrl':
//           'https://www.vidavetcare.com/wp-content/uploads/sites/234/2022/04/golden-retriever-dog-breed-info.jpeg',
//     },
//     {
//       'name': 'Max',
//       'breed': 'Bulldog',
//       'age': 5,
//       'imageUrl':
//           'https://www.zigly.com/media/mageplaza/blog/post/b/u/bull_dog_101.png',
//     },
//     {
//       'name': 'Luna',
//       'breed': 'Siamese Cat',
//       'age': 2,
//       'imageUrl':
//           'https://images.wagwalkingweb.com/media/daily_wag/blog_articles/hero/1678934108.5188236/everything-you-need-to-know-about-siamese-cats.png',
//     },
//     {
//       'name': 'Charlie',
//       'breed': 'Beagle',
//       'age': 4,
//       'imageUrl':
//           'https://lirp.cdn-website.com/e5dbb6fb/dms3rep/multi/opt/coy-beagle-puppy-234x316.dm.edit_l8ICpI-400w.jpg',
//     },
//   ];

//   final List<Map<String, dynamic>> upcomingReminders = const [
//     {
//       'title': 'Vaccination for Bella',
//       'date': 'Thu, Jul 1',
//       'time': '10:00 AM',
//       'status': 'Upcoming',
//     },
//     {
//       'title': 'Grooming for Max',
//       'date': 'Fri, Jul 2',
//       'time': '2:00 PM',
//       'status': 'Upcoming',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(20),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 const CircleAvatar(
//                   radius: 50,
//                   backgroundImage: AssetImage('assets/CURA PET.png'),
//                 ),
//                 const SizedBox(height: 20),

//                 // Name field
//                 TextFormField(
//                   controller: nameController,
//                   decoration: const InputDecoration(
//                     labelText: 'Name',
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.person),
//                   ),
//                   validator:
//                       (value) =>
//                           value == null || value.isEmpty
//                               ? 'Enter your name'
//                               : null,
//                 ),
//                 const SizedBox(height: 20),

//                 // Password field
//                 TextFormField(
//                   controller: passwordController,
//                   obscureText: _obscurePassword,
//                   decoration: InputDecoration(
//                     labelText: 'Password',
//                     border: const OutlineInputBorder(),
//                     prefixIcon: const Icon(Icons.lock),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _obscurePassword
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _obscurePassword = !_obscurePassword;
//                         });
//                       },
//                     ),
//                   ),
//                   validator:
//                       (value) =>
//                           (value == null || value.length < 6)
//                               ? 'Password must be at least 6 characters'
//                               : null,
//                 ),
//                 const SizedBox(height: 30),

//                 // Login button
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: _onLogin,
//                     style: ElevatedButton.styleFrom(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       backgroundColor: Colors.cyan,
//                     ),
//                     child: const Text(
//                       'Login',
//                       style: TextStyle(fontSize: 18, color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
