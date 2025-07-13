// import 'package:cura_pet/features/home/presentation/view/home_view.dart';
// import 'package:cura_pet/features/pets/presentation/pets_view.dart';
// import 'package:cura_pet/features/user/presentation/view/appointment_view.dart';
// import 'package:cura_pet/features/user/presentation/view/login_view.dart';
// import 'package:cura_pet/features/user/presentation/view/profile_view.dart';
// import 'package:cura_pet/features/user/presentation/view/signup_view.dart';
// import 'package:flutter/material.dart';

// class NavigationView {
//   static Route<dynamic> generateRoute(RouteSettings settings) {
//     switch (settings.name) {
//       case '/':
//         return MaterialPageRoute(builder: (_) => const LoginView());

//       case '/signup':
//         return MaterialPageRoute(builder: (_) => const SignupView());

//       case '/dashboard':
//         return MaterialPageRoute(builder: (_) => HomeView());

//       case '/pets':
//         return MaterialPageRoute(builder: (_) => const PetsView());

//       case '/appointments':
//         return MaterialPageRoute(builder: (_) => AppointmentView());

//       case '/profile':
//         return MaterialPageRoute(builder: (_) => ProfileView());

//       default:
//         return MaterialPageRoute(
//           builder:
//               (_) =>
//                   const Scaffold(body: Center(child: Text('Page not found'))),
//         );
//     }
//   }
// }
