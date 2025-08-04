// // // import 'dart:async';
// // // import 'package:flutter_bloc/flutter_bloc.dart';
// // // import 'package:flutter/material.dart';

// // // class SplashViewModel extends Cubit<void> {
// // //   SplashViewModel() : super(null);

// // //   void startTimer(BuildContext context) {
// // //     Timer(const Duration(seconds: 3), () {
// // //       if (context.mounted) {
// // //         Navigator.pushReplacementNamed(context, '/login');
// // //       }
// // //     });
// // //   }
// // // }

// // import 'dart:async';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';

// // class SplashViewModel extends Cubit<void> {
// //   SplashViewModel() : super(null);

// //   /// Wait 3 seconds, then navigate to the Register screen.
// //   void startTimer(BuildContext context) {
// //     Timer(const Duration(seconds: 3), () {
// //       if (context.mounted) {
// //         Navigator.pushReplacementNamed(context, '/register');
// //       }
// //     });
// //   }
// // }

// import 'package:cura_pet/app/service_locator/service_locator.dart';
// import 'package:cura_pet/features/user/presentation/view/register_view.dart';
// import 'package:cura_pet/features/user/presentation/view_model/register_view_model/register_view_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class SplashViewModel extends Cubit<void> {
//   SplashViewModel() : super(null);

//   Future<void> init(BuildContext context) async {
//     await Future.delayed(const Duration(seconds: 2), () async {
//       if (context.mounted) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder:
//                 (context) => BlocProvider.value(
//                   value: serviceLocator<RegisterViewModel>(),
//                   child: RegisterView(),
//                 ),
//           ),
//         );
//       }
//     });
//   }
// }

import 'package:cura_pet/app/service_locator/service_locator.dart';
import 'package:cura_pet/features/user/presentation/view/register_view.dart';
import 'package:cura_pet/features/user/presentation/view_model/register_view_model/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashViewModel extends Cubit<void> {
  SplashViewModel() : super(null);

  Future<void> startTimer(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2), () async {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder:
                (context) => BlocProvider.value(
                  value: serviceLocator<RegisterViewModel>(),
                  child: const RegisterPage(),
                ),
          ),
        );
      }
    });
  }
}
