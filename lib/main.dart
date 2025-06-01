import 'package:cura_pet/app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

// import 'package:cura_pet/view/dashboard_page.dart';
// import 'package:cura_pet/view/login_page.dart';
// import 'package:cura_pet/view/register_page.dart';
// import 'package:cura_pet/view/splash_screen.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Cura Pet',
//       theme: ThemeData(
//         primarySwatch: Colors.teal,
//         scaffoldBackgroundColor: Colors.white,
//         fontFamily: 'Arial',
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.teal,
//             foregroundColor: Colors.white,
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         ),
//       ),
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const SplashScreen(),
//         '/login': (context) => const LoginPage(),
//         '/register': (context) => const RegisterPage(),
//         '/dashboard': (context) => const DashboardPage(),
//       },
//     );
//   }
// }
