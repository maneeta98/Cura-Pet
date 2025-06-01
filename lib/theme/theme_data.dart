import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    useMaterial3: false,
    primarySwatch: Colors.teal,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Montserrat',
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.teal,
    ),

    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
      ),
      bodyMedium: TextStyle(
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
      ),
      bodySmall: TextStyle(
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
      ),
      titleLarge: TextStyle(
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
      ),
      titleMedium: TextStyle(
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
      ),
      titleSmall: TextStyle(
        fontWeight: FontWeight.w700,
        fontStyle: FontStyle.italic,
      ),
    ),

    // textTheme: const TextTheme(
    //   bodyLarge: TextStyle(fontWeight: FontWeight.w700), // Regular
    //   bodyMedium: TextStyle(fontWeight: FontWeight.w700),
    //   bodySmall: TextStyle(fontWeight: FontWeight.w700),
    //   titleLarge: TextStyle(fontWeight: FontWeight.w700), // Bold
    //   titleMedium: TextStyle(fontWeight: FontWeight.w700),
    //   titleSmall: TextStyle(fontWeight: FontWeight.w700),
    // ),
  );
}
