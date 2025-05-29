import 'package:cura_pet/bottom/dashboard.dart';
import 'package:cura_pet/theme/theme_data.dart';

import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DashboardScreen(),
      theme: getApplicationTheme(),
    );
  }
}
