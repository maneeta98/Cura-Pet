import 'package:cura_pet/app/app.dart';
import 'package:cura_pet/app/service_locator/service_locator.dart';
import 'package:cura_pet/core/network/local/hive_service.dart';
import 'package:cura_pet/features/user/data/model/user_hive_model.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService().init();
  await initDependencies();
  runApp(App());
}

class HiveService {
  Future<void> init() async {}

  Future login(String email, String password) async {}

  Future<void> register(UserHiveModel userHiveModel) async {}
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
